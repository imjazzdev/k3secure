import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/controllers/WelcomeController.dart';
import 'package:k3secure/pages/AuthPage/auth_page.dart';
import 'package:k3secure/pages/Menu/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    // Perform the session check here
    _checkSession(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 100,
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Logo_PKT.png',
                    width: 300,
                    height: 200,
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        'Selamat Datang di K3Secure',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          'Mulai',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.orange,
            height: 100,
          ),
        ],
      ),
    );
  }

  void _checkSession(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token =
        prefs.getString('token'); // Get the token from the session

    if (token != null) {
      // Session is already saved, navigate the user to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ),
      );
    }
  }
}
