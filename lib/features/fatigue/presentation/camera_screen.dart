import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fatigue_vision/core/widgets/glass_card.dart';
import 'package:fatigue_vision/features/fatigue/presentation/fatigue_controller.dart';
import 'package:fatigue_vision/features/fatigue/presentation/widgets/fatigue_gauge.dart';
import 'package:fatigue_vision/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  int _sensorOrientation = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_initializeCamera());
    unawaited(WakelockPlus.enable());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_controller?.dispose());
    unawaited(WakelockPlus.disable());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      ref.read(fatigueControllerProvider.notifier).stop();
      unawaited(_controller?.dispose());
    } else if (state == AppLifecycleState.resumed) {
      unawaited(_initializeCamera());
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    // Prefer front camera
    final frontCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    try {
      await _controller!.initialize();
      _sensorOrientation = frontCamera.sensorOrientation;

      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });

      _startImageStream();
    } on CameraException catch (e) {
      debugPrint('Camera error: $e');
    } on Exception catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  void _startImageStream() {
    // Throttle processing to ~10fps to save CPU/Battery
    var frameCount = 0;
    unawaited(
      _controller?.startImageStream((image) {
        frameCount++;
        if (frameCount % 3 != 0) {
          return; // Process every 3rd frame (assuming 30fps -> 10fps)
        }

        if (_controller != null) {
          unawaited(
            ref
                .read(fatigueControllerProvider.notifier)
                .processFrame(
                  image,
                  _controller!.description,
                  _sensorOrientation,
                ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fatigueState = ref.watch(fatigueControllerProvider);

    if (!_isCameraInitialized || _controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Camera Feed
          CameraPreview(_controller!),

          // Overlay UI
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GlassCard(
                        borderRadius: BorderRadius.circular(30),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Text(
                          fatigueState.isScanning
                              ? context.l10n.liveMonitoring.toUpperCase()
                              : context.l10n.paused.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GlassCard(
                        borderRadius: BorderRadius.circular(30),
                        padding: const EdgeInsets.all(8), // Reduced padding
                        child: IconButton(
                          iconSize: 20, // Reduced icon size
                          constraints:
                              const BoxConstraints(), // Removes default minimum size
                          padding: EdgeInsets.zero, // Removes internal padding
                          icon: const Icon(
                            Icons
                                .close, // 'Close' is more standard for right-side exit
                            color: Colors.white,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Bottom Dashboard
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: GlassCard(
                    opacity: 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Gauge
                        FatigueGauge(
                          earValue: fatigueState.currentEAR,
                          level: fatigueState.fatigueLevel,
                        ),

                        const SizedBox(width: 16),

                        // Stats / Instructions
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.l10n.driverIntegrity.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  fatigueState.fatigueLevel ==
                                          FatigueLevel.normal
                                      ? context.l10n.optimal.toUpperCase()
                                      : context.l10n.warning.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color:
                                        fatigueState.fatigueLevel ==
                                            FatigueLevel.normal
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.face_retouching_natural,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      context.l10n.keepFaceVisible,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Flash overlay on Drowsy
          if (fatigueState.fatigueLevel == FatigueLevel.drowsy)
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red.withValues(alpha: 0.5),
                    width: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
