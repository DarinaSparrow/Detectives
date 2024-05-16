import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';
import '../service/userSettings.dart';

class appService {
  static late FlutterLocalNotificationsPlugin _notifications;

  static const String summaryNotificationIcon = '@drawable/detective_app_icon';
  static const String anyaIcon = '@drawable/anya_icon';
  static const String darinaIcon = '@drawable/darina_icon';
  static const String danyaIcon = '@drawable/danya_icon';
  static const String evgeniyIcon = '@drawable/evgeniy_icon';
  static const String kirillIcon = '@drawable/kirill_icon';
  static const String lizaIcon = '@drawable/liza_icon';

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
    AndroidInitializationSettings('@drawable/detective_app_icon');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    _notifications.initialize(initializationSettings);
  }

  static Future<void> sendNotification(String title, String body) async {
    try {
      final int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const String groupKey = 'detective_app.notifications';

      String currentIcon = '';
      switch(title){
        case 'Аня':
          currentIcon = appService.anyaIcon;
          break;
        case 'Дарина':
          currentIcon = appService.darinaIcon;
          break;
        case 'Даня':
          currentIcon = appService.danyaIcon;
          break;
        case 'Женя':
          currentIcon = appService.evgeniyIcon;
          break;
        case 'Кирилл':
          currentIcon = appService.kirillIcon;
          break;
        case 'Лиза':
          currentIcon = appService.lizaIcon;
          break;
      }

      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1500',
        'Detectives',
        channelDescription: 'Detective chat application',
        importance: Importance.max,
        priority: Priority.high,
        icon: currentIcon,
        groupKey: groupKey,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

      await _notifications.show(notificationId, title, body, platformChannelSpecifics);

      const AndroidNotificationDetails summaryNotificationAndroidSpecifics = AndroidNotificationDetails(
        '1500',
        'Detectives',
        channelDescription: 'Detective chat application',
        importance: Importance.max,
        priority: Priority.high,
        icon: appService.summaryNotificationIcon,
        groupKey: groupKey,
        setAsGroupSummary: true,
      );

      const NotificationDetails summaryNotificationPlatformSpecifics = NotificationDetails(android: summaryNotificationAndroidSpecifics);

      // Отправка сводного уведомления
      await _notifications.show(0, 'Таинственная пропажа', 'Новые сообщения', summaryNotificationPlatformSpecifics);
    } catch (e) {
      print("Failed to send notification: $e");
    }
  }

  static Future<void> vibrate({int duration = 20, int amplitude = 30}) async {
    if (userSettings.vibration == true) {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator ?? false) {
        Vibration.vibrate(
          duration: duration,
          amplitude: amplitude,
        );

      }
    }
  }

  static void exitApp() {
    SystemNavigator.pop();
  }
}