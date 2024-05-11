import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userSettings.dart';

class appService {
  late SharedPreferences _prefs;
  late FlutterLocalNotificationsPlugin _notifications;

  static const String _vibrationKey = 'vibration';
  static const String _soundKey = 'sound'; // Добавляем ключ для сохранения звука
  static const String _musicKey = 'music'; // Добавляем ключ для сохранения музыки
  static const String _selectedSpeedKey = 'selectedSpeed';
  static const String _nicknameKey = 'nickname'; // Добавляем ключ для сохранения никнейма
  static const String _statusKey = 'status'; // Добавляем ключ для сохранения статуса

  appService() {
    _initSharedPreferences();
    _initNotifications();
    _loadSettings();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _initNotifications() {
    _notifications = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    _notifications.initialize(initializationSettings);
  }

  Future<void> sendNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _notifications.show(0, title, body, platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> toggleFlashlight() async {
    try {
      const MethodChannel flashlightChannel =
      MethodChannel('samples.flutter.dev/flashlight');
      await flashlightChannel.invokeMethod('toggleFlashlight');
    } on PlatformException catch (e) {
      print("Failed to toggle flashlight: '${e.message}'.");
    }
  }

  Future<void> _loadSettings() async {
    userSettings.vibration = _prefs.getBool(_vibrationKey) ?? true;
    userSettings.sound = _prefs.getBool(_soundKey) ?? true; // Загружаем сохраненный звук
    userSettings.music = _prefs.getBool(_musicKey) ?? true; // Загружаем сохраненную музыку
    userSettings.selectedSpeed = _prefs.getInt(_selectedSpeedKey) ?? 1;
    userSettings.nickname = _prefs.getString(_nicknameKey) ?? ''; // Загружаем сохраненный никнейм
    userSettings.status = _prefs.getString(_statusKey) ?? ''; // Загружаем сохраненный статус
  }

  Future<void> _saveSettings() async {
    await _prefs.setBool(_vibrationKey, userSettings.vibration);
    await _prefs.setBool(_soundKey, userSettings.sound); // Сохраняем звук
    await _prefs.setBool(_musicKey, userSettings.music); // Сохраняем музыку
    await _prefs.setInt(_selectedSpeedKey, userSettings.selectedSpeed);
    await _prefs.setString(_nicknameKey, userSettings.nickname); // Сохраняем никнейм
    await _prefs.setString(_statusKey, userSettings.status); // Сохраняем статус
  }

  // Добавляем метод для сохранения настроек полей ввода
  Future<void> saveInputFields(String nickname, String status) async {
    userSettings.nickname = nickname;
    userSettings.status = status;
    await _saveSettings();
  }
}
