import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppService {
  late FlutterLocalNotificationsPlugin _notifications;

  AppService() {
    _initNotifications();
  }

  void _initNotifications() {
    _notifications = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
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
}
