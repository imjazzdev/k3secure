import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/controllers/login_controller.dart';
import 'package:k3secure/pages/Menu/dashboard_page.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              if (_loginController.isLoggedIn.value) {
                return Text('Anda sudah masuk!');
              } else {
                return Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'NPK'),
                      onChanged: (value) {
                        _loginController.npk.value = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Password'),
                      onChanged: (value) {
                        _loginController.password.value = value;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _loginController.login();
                       
                      },
                      child: Text('Login'),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
