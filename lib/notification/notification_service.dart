import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:school_notifier/event_repository_test/event_page.dart';
import 'package:school_notifier/home/view/home_page.dart';
import 'package:school_notifier/main.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? selectedNotificationPayload;

  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  int id = 0;
  String? title = "Event Title";
  String? body = "Event Description";
  String? payload = "data";

  Future<void> init() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    String initialRoute = HomePage.routeName;
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails!.payload;
      initialRoute = EventPage.routeName;
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: showNotification);
  }

  Future<void> showNotification(String? payload) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'channel id', 'channel name', 'channel description',
            importance: Importance.max, priority: Priority.high);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
    print("Notification Sent");
  }
}
