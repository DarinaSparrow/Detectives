import 'package:audioplayers/audioplayers.dart';
import 'package:detectives/service/userSettings.dart';



import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  static final SoundPlayer _instance = SoundPlayer._internal();

  // Приватный конструктор
  SoundPlayer._internal() {
    // Слушаем событие завершения проигрывания
    _audioPlayer.onPlayerComplete.listen((event) {
      _onCompletion?.call();
      _onCompletion = null; // Очищаем callback после вызова
    });
  }

  // Статический метод для получения единственного экземпляра класса
  static SoundPlayer get instance => _instance;

  Function()? _onCompletion; // Тип колбэка должен быть Function

  Future<void> playSound(String assetPath, {bool loop = false, Function()? onCompletion}) async {
    if (userSettings.sound == true) {
      _onCompletion = onCompletion;
      if (loop) {
        _audioPlayer.setReleaseMode(ReleaseMode.loop);
      } else {
        _audioPlayer.setReleaseMode(ReleaseMode.release);
      }
      await _audioPlayer.play(AssetSource('audio/$assetPath'));
    }
  }

  Future<void> resumeSound() async {
    if (userSettings.sound == true) {
      await _audioPlayer.resume();
    }
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  // Статический метод для освобождения ресурсов
  static void disposeInstance() {
    _instance.dispose();
  }
}
