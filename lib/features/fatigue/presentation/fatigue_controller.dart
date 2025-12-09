import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fatigue_vision/config/injection.dart';
import 'package:fatigue_vision/core/services/alert_service.dart';
import 'package:fatigue_vision/features/fatigue/data/services/face_detector_service.dart';
import 'package:fatigue_vision/features/fatigue/domain/logic/ear_calculator.dart';
import 'package:fatigue_vision/features/history/data/history_provider.dart';
import 'package:fatigue_vision/features/history/data/history_repository.dart';
import 'package:fatigue_vision/features/history/domain/entities/history_event.dart';
import 'package:fatigue_vision/features/settings/presentation/settings_controller.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fatigue_controller.freezed.dart';
part 'fatigue_controller.g.dart';

enum FatigueLevel { normal, drowsy }

@freezed
abstract class FatigueState with _$FatigueState {
  const factory FatigueState({
    @Default(false) bool isScanning,
    @Default(0.0) double currentEAR,
    @Default(FatigueLevel.normal) FatigueLevel fatigueLevel,
    @Default([]) List<double> historyEAR, // Last N frames
  }) = _FatigueState;
}

@riverpod
class FatigueController extends _$FatigueController {
  FaceDetectorService? _detectorService;
  AlertService? _alertService;
  HistoryRepository? _historyRepository;

  static const int _historySize = 10;
  bool _mounted = true;
  DateTime? _lastAlertTime;

  @override
  FatigueState build() {
    _detectorService = getIt<FaceDetectorService>();
    _alertService = getIt<AlertService>();
    _historyRepository = getIt<HistoryRepository>();
    _mounted = true;
    ref.onDispose(() => _mounted = false);
    return const FatigueState();
  }

  Future<void> processFrame(
    CameraImage image,
    CameraDescription camera,
    int orientation,
  ) async {
    if (_detectorService == null || !_mounted) return;

    final landmarks = await _detectorService!.processImage(
      image,
      camera,
      orientation,
    );

    if (!_mounted) return;

    if (landmarks == null) {
      if (!state.isScanning) {
        state = state.copyWith(
          isScanning: true,
          currentEAR: 0,
          fatigueLevel: FatigueLevel.normal,
        );
      } else if (state.currentEAR != 0) {
        state = state.copyWith(
          currentEAR: 0,
          fatigueLevel: FatigueLevel.normal,
        );
      }
      return;
    }

    final avgEAR = EARCalculator.calculateAvg(landmarks);

    final newHistory = [...state.historyEAR, avgEAR];
    if (newHistory.length > _historySize) {
      newHistory.removeAt(0);
    }

    final smoothEAR = newHistory.reduce((a, b) => a + b) / newHistory.length;

    // Get Settings
    final settings = ref.read(settingsProvider);
    final threshold = switch (settings.sensitivity) {
      Sensitivity.low => 0.18,
      Sensitivity.medium => 0.22,
      Sensitivity.high => 0.26,
    };

    final level = smoothEAR < threshold
        ? FatigueLevel.drowsy
        : FatigueLevel.normal;

    // Handle Drowsiness
    if (level == FatigueLevel.drowsy) {
      _handleDrowsy(settings);
    }

    state = state.copyWith(
      currentEAR: smoothEAR,
      historyEAR: newHistory,
      fatigueLevel: level,
      isScanning: true,
    );
  }

  void _handleDrowsy(SettingsState settings) {
    final now = DateTime.now();
    // Debounce alerts: max 1 per 3 seconds
    if (_lastAlertTime == null ||
        now.difference(_lastAlertTime!) > const Duration(seconds: 3)) {
      _lastAlertTime = now;

      // Alert
      if (settings.enableAudio || settings.enableVibration) {
        unawaited(
          _alertService?.playAlert(
            enableAudio: settings.enableAudio,
            enableVibration: settings.enableVibration,
          ),
        );
      }

      // Save History
      unawaited(
        _historyRepository?.saveEvent(
          HistoryEvent(
            date: now,
            level: 'Drowsy',
            ear: state.currentEAR,
          ),
        ),
      );

      ref.invalidate(historyProvider);
    }
  }

  void stop() {
    state = state.copyWith(
      isScanning: false,
      currentEAR: 0,
      fatigueLevel: FatigueLevel.normal,
    );
  }
}
