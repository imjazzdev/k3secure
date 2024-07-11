import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';

class ProfilPage extends StatefulWidget {
  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Future<void> _scanQRCode() async {
  var nama = TextEditingController(text: Constant.USERNAME);

  var npk = TextEditingController(text: Constant.NPK);

  var telp = TextEditingController(text: Constant.TELP);

  void simpanProfil() async {
    final doc = await FirebaseFirestore.instance
        .collection('DATA_PEGAWAI')
        .doc(Constant.EMAIL);

    doc.update({
      'nama': nama.text,
      'npk': npk.text,
      'telp': telp.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: double.infinity,
        title: Text('Profil'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/th_2.jpg'),
            SizedBox(
              height: 30,
            ),
            Card(
              color: Colors.blue.shade400,
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(
                              'Role ',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                        Expanded(
                            flex: 6,
                            child: Text(Constant.isAdmin ? 'Admin' : 'Pegawai',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Nama ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))),
                        Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 30,
                            child: TextFormField(
                              controller: nama,
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('NPK ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))),
                        Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 30,
                            child: TextFormField(
                              controller: npk,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Telp ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))),
                        Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 30,
                            child: TextFormField(
                              controller: telp,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Email ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))),
                        Expanded(
                            flex: 1,
                            child: Text(
                              ':',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                        Expanded(
                            flex: 6,
                            child: Text(
                              Constant.EMAIL,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.question,
                          desc: 'Simpan perubahan ?',
                          btnOkOnPress: () {
                            simpanProfil();
                            setState(() {});
                          },
                          btnCancelOnPress: () {})
                      .show();
                },
                child: Text('Simpan Profil'))
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/th_2.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    Constant.isAdmin ? 'Admin' : 'Pegawai',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${FirebaseAuth.instance.currentUser!.email}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Riwayat'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/riwayat');
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifikasi'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/notifikasi');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Keluar',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/auth', (route) => false);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/riwayat');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/qrcode');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/notifikasi');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profil');
          }
        },
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
