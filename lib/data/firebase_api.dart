import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // ignore: prefer_const_constructors
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'hight_important_channel', 'High Importance Notifications',
      importance: Importance.max, playSound: true);

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final FCMToken = await _firebaseMessaging.getToken();

    print('TOKEN : $FCMToken');
  }

  static Future localNotifInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings(
            // onDidReceiveLocalNotification: onDidReceiveLocalNotification
            );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  @pragma('vm:entry-point')
  static void onNotificationTap(NotificationResponse notificationResponse) {
    print('INI D EKSEKUSI');
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (message.notification != null) {
      print("Menerima notification background");
    }
  }

  static Future<void> firebaseMessagingForeground(RemoteMessage message) async {
    String payloadData = jsonEncode(message.data);
    print('Menerima notifikasi Foreground!');
    print('Message data: ${message.notification!}');

    if (message.notification != null) {
      print('NOTIFIKASI TIDAK NULL');
      FirebaseAPI.showSimpleNotif(
          title: message.notification!.title.toString(),
          body: message.notification!.body.toString(),
          payload: payloadData);
      print(
          'Message also contained a notification: ${message.notification!.body}');
    }
  }

  static Future showSimpleNotif({
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: 'channelDescription',
            icon: '@mipmap/ic_launcher',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        1, title, body, notificationDetails);
  }
}
