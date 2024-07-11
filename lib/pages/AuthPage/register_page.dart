import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // final RegisterController _registerController = Get.put(RegisterController());
  bool isVisible = true;
  bool isLoading = false;

  var emailC = TextEditingController();
  var namaC = TextEditingController();
  var npkC = TextEditingController();
  var passwordC = TextEditingController();
  var telpC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            controller: emailC,
                            decoration: InputDecoration(labelText: 'Email'),
                            onChanged: (value) {},
                          ),
                          TextField(
                            controller: namaC,
                            decoration: InputDecoration(labelText: 'Nama'),
                            onChanged: (value) {},
                          ),
                          TextField(
                            controller: npkC,
                            decoration: InputDecoration(labelText: 'NPK'),
                            onChanged: (value) {},
                          ),
                          TextField(
                            controller: passwordC,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: Icon(isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                            onChanged: (value) {},
                            obscureText: isVisible,
                          ),
                          TextField(
                            controller: telpC,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Telp'),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    registerUser();
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
          isLoading == false
              ? SizedBox()
              : Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                )
        ],
      ),
    );
  }

  Future registerUser() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailC.text, password: passwordC.text);
    final doc = await FirebaseFirestore.instance
        .collection('DATA_PEGAWAI')
        .doc(emailC.text);

    final order = RegisterUserModel(
        email: emailC.text,
        nama: namaC.text,
        npk: npkC.text,
        telp: telpC.text,
        isAdmin: false);
    final json = order.toJson();
    await doc.set(json);
    // ignore: use_build_context_synchronously
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            title: 'Data berhasil ditambahkan',
            desc: 'Kembali ke halaman login',
            btnOkOnPress: () {
              Navigator.pop(context);
            },
            btnCancelOnPress: () {})
        .show();
  }
}

class RegisterUserModel {
  final String email, nama, npk, telp;
  final bool isAdmin;

  RegisterUserModel(
      {required this.email,
      required this.nama,
      required this.npk,
      required this.telp,
      required this.isAdmin});

  Map<String, dynamic> toJson() => {
        'email': email,
        'nama': nama,
        'npk': npk,
        'telp': telp,
        'isAdmin': isAdmin
      };
}
