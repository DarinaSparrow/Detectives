import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  static final SoundPlayer _instance = SoundPlayer._internal();

  factory SoundPlayer() {
    return _instance;
  }

  SoundPlayer._internal();

  Future<void> playSound(String assetPath, {bool loop = false}) async {
    if (loop) {
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
    }
    else {
      _audioPlayer.setReleaseMode(ReleaseMode.stop);
    }
    await _audioPlayer.play(AssetSource('audio/$assetPath'));
  }

  Future<void> resumeSound() async {
    await _audioPlayer.resume();
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
