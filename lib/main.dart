import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:k3secure/data/firebase_api.dart';
import 'package:k3secure/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:k3secure/firebase_options.dart';
import 'package:month_year_picker/month_year_picker.dart';

// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (message.notification != null) {
//     print("Menerima notification background");
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //on background notif tapped
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   if (message.notification != null) {
  //     print('Background notifikasi di tap');
  //   }
  // });

  await FirebaseAPI().initNotification();
  await FirebaseAPI.localNotifInit();

  //Listen to background notification
  FirebaseMessaging.onBackgroundMessage(
      FirebaseAPI.firebaseMessagingBackgroundHandler);

  //Handle to foreground notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
  });

  // await FirebaseAPI()
  //     .flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(FirebaseAPI().channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
          localizationsDelegates: [
            MonthYearPickerLocalizations.delegate,
          ],
          initialRoute: Routes.WelcomePage,
          getPages: AppPages.routes),
    );
  }
}
