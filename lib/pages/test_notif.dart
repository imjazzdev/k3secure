import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TestNotif extends StatelessWidget {
  const TestNotif({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: Text('TEST NOTIF'),
      ),
      body: Text(data.data.toString()),
    );
  }
}
