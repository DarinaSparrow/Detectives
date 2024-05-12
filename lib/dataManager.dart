import 'dart:convert';
import 'dart:io';
import 'userSettings.dart';
import 'package:path_provider/path_provider.dart';

class dataManager {
  static late String _settingsFilePath;

  static Future<void> _initFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    _settingsFilePath = '${directory.path}/userSettings.json';
  }

  static Future<void> loadSettings() async {
    try {
      await _initFilePath();
      final File file = File(_settingsFilePath);
      if (await file.exists()) {
        final String content = await file.readAsString();
        final Map<String, dynamic> settingsMap = json.decode(content);
        userSettings.vibration = settingsMap['vibration'] ?? true;
        userSettings.sound = settingsMap['sound'] ?? true;
        userSettings.music = settingsMap['music'] ?? true;
        userSettings.selectedSpeed = settingsMap['selectedSpeed'] ?? 1;
        userSettings.nickname = settingsMap['nickname'] ?? '';
        userSettings.status = settingsMap['status'] ?? '';
        userSettings.phoneNumber = settingsMap['phoneNumber'] ?? '';
      }
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  static Future<void> saveSettings() async {
    try {
      await _initFilePath();
      final Map<String, dynamic> settingsMap = {
        'vibration': userSettings.vibration,
        'sound': userSettings.sound,
        'music': userSettings.music,
        'selectedSpeed': userSettings.selectedSpeed,
        'nickname': userSettings.nickname,
        'status': userSettings.status,
        'phoneNumber': userSettings.phoneNumber,
      };
      final String jsonString = json.encode(settingsMap);
      final File file = File(_settingsFilePath);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving settings: $e');
    }
  }
}
