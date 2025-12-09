import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:vibration/vibration.dart';

@singleton
class AlertService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Future<void> playAlert({
    required bool enableAudio,
    required bool enableVibration,
  }) async {
    if (_isPlaying) return;
    _isPlaying = true;

    if (enableVibration) {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(pattern: [500, 500, 500]);
      }
    }

    // Play Sound
    if (enableAudio) {
      try {
        await _audioPlayer.play(AssetSource('sounds/alarm.mp3'));
      } on Exception catch (e) {
        // Fail silently if asset is missing, or log
        debugPrint('Audio alert failed: $e');
      }
    }

    _isPlaying = false;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }
}
