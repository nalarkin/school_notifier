import 'dart:convert';
import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:school_notifier/event_repository_test/event_page.dart';
import 'package:school_notifier/home/view/home_page.dart';
import 'package:school_notifier/main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

    // setting timzeone to new york
    tz.initializeTimeZones();
    var atlanta = tz.getLocation('America/New_York');
    tz.setLocalLocation(atlanta);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> scheduleEventNotification(FirestoreEvent event) async {
    final eventStart = tz.TZDateTime.from(
      event.eventStartTime,
      tz.local,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
        event.eventUID.hashCode,
        event.title,
        // event.description,
        event.eventUID.hashCode.toString(),
        eventStart,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                "channel id", "channel name", "channel description",
                priority: Priority.high, importance: Importance.max)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
  Future<void> scheduleMultipleEventNotification(List<FirestoreEvent> events) async {
    for (final event in events) {
      final eventStart = tz.TZDateTime.from(
            event.eventStartTime,
            tz.local,
          );

          await flutterLocalNotificationsPlugin.zonedSchedule(
              event.eventUID.hashCode,
              event.title,
              'event.description',
              // event.eventUID.hashCode.toString(),
              eventStart,
              const NotificationDetails(
                  android: AndroidNotificationDetails(
                      "channel id", "channel name", "channel description",
                      priority: Priority.max, importance: Importance.max)),
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> checkPendingNotificationRequests(context) async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (final notif in pendingNotificationRequests) {
      print(notif.id);
      print(notif.body);
      print(notif.title);
      print(notif.payload);
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
            Text('${pendingNotificationRequests.length} pending notification '
                'requests'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
