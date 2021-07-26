import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:school_notifier/main.dart';

class NotificationService {
  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }
}

Future<void> selectNotification(String? payload) async {
  // handles notification tapped logic here

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'test', 'School Notifier', 'Here is a test notification',
      importance: Importance.max, priority: Priority.max, showWhen: false);

  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', platformChannelSpecifics,
      payload: 'data');
}
