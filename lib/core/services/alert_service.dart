import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'package:injectable/injectable.dart';

@singleton
class AlertService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Future<void> playAlert() async {
    if (_isPlaying) return;
    _isPlaying = true;

    // Play a beep sound (using a default URL or asset if available)
    // For POC, we'll try to use a system sound or a generic url if no asset
    // Ideally user should bundle an asset. Let's assume we need to add one.
    // As a fallback, we just vibrate heavily which is more reliable without assets.

    // Vibrate
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(pattern: [500, 500, 500]);
    }

    // Play Sound (Placeholder for asset)
    // await _audioPlayer.play(AssetSource('sounds/alarm.mp3'));

    _isPlaying = false;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }
}
