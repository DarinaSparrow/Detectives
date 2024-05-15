import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

class appService {
  static late FlutterLocalNotificationsPlugin _notifications;

  static Future<void> initialize() async {
    await _requestNotificationPermission();
    _initNotifications();
  }

  static Future<void> _requestNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Permission not granted for notifications');
    }
  }

  static void _initNotifications() {
    _notifications = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    _notifications.initialize(initializationSettings);
  }

  static Future<void> sendNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        '1500',
        'Detectives',
        channelDescription: 'Detective chat application',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
      await _notifications.show(0, title, body, platformChannelSpecifics,
          payload: 'item x');
    } catch (e) {
      print("Failed to send notification: $e");
    }
  }

  static Future<void> vibrate() async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator ?? false) {
      Vibration.vibrate(duration: 500);
    }
  }

  static void exitApp() {
    SystemNavigator.pop();
  }
}