import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/constant/constant.dart';
import 'package:k3secure/controllers/AuthController.dart';
import 'package:k3secure/pages/AuthPage/forgot_password_page.dart';
import 'package:k3secure/pages/AuthPage/register_page.dart';
import 'package:k3secure/pages/Menu/dashboard_page.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var emailC = TextEditingController();

  var passwordC = TextEditingController();

  Future getDataUser() async {
    var user = await FirebaseFirestore.instance
        .collection('DATA_PEGAWAI')
        .doc(Constant.EMAIL)
        .get();
    Constant.USERNAME = user['nama'].toString();
    Constant.NPK = user['npk'].toString();
    Constant.TELP = user['telp'].toString();
    Constant.EMAIL = user['email'].toString();
    print('USER LOGIN');
    print('Nama : ${Constant.USERNAME}');
    print('NPK : ${Constant.NPK}');
    print('Email : ${Constant.EMAIL}');
    print('Status Admin : ${Constant.isAdmin}');
  }

  @override
  void initState() {
    Constant.isAdmin = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.toNamed('/welcome');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/Logo_PKT.png',
                  width: 300,
                  height: 200,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailC,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
                    child: Text('Sign Up'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ));
                    },
                    child: Text('Forgot password'),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // bool loggedIn = await controller.login(
                    //     controller.npkController.text,
                    //     controller.passwordController.text);
                    // if (loggedIn) {
                    //   Get.offAllNamed('/dashboard');

                    // } else {
                    //   Get.snackbar('Login Gagal', 'NPK atau password salah');
                    // }

                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailC.text, password: passwordC.text);
                      Constant.EMAIL = await FirebaseAuth
                          .instance.currentUser!.email
                          .toString();
                      getDataUser();

                      // ignore: use_build_context_synchronously

                      if (FirebaseAuth.instance.currentUser!.email ==
                          'ariefdzulqanii10@gmail.com') {
                        Constant.isAdmin = true;
                      }

                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardPage(),
                          ),
                          (route) => false);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'wrong-password') {
                        setState(() {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.warning,
                            title: 'Email & password salah. Coba lagi',
                            btnOkOnPress: () {},
                          ).show();

                          emailC.clear();
                          passwordC.clear();
                        });
                      } else if (e.code == 'user-not-found') {
                        setState(() {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            title: 'User tidak ditemukan. Coba lagi',
                            btnOkOnPress: () {},
                          ).show();

                          emailC.clear();
                          passwordC.clear();
                        });
                      } else {
                        // ignore: use_build_context_synchronously
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.warning,
                          title: 'Periksa internet anda',
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }
                  },
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.orange,
        height: 100,
      ),
    );
  }
}

// void main() {
//   runApp(GetMaterialApp(home: AuthPage()));
// }
