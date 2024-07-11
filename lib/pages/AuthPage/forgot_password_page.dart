import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Input email for reset password',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: emailC.text);
                  // ignore: use_build_context_synchronously
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.info,
                    desc: 'Pemberitahuan reset password dikirim, check email!',
                    btnOkOnPress: () {
                      Navigator.pop(context);
                    },
                  ).show();
                } on FirebaseAuthException catch (err) {
                  throw Exception(err.message.toString());
                } catch (err) {
                  throw Exception(err.toString());
                }
              },
              child: Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}
