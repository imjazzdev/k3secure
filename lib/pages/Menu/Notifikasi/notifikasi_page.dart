import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k3secure/pages/Menu/Notifikasi/apd.dart';
import 'package:k3secure/pages/Menu/Notifikasi/p3k.dart';

import '../../../constant/constant.dart';
import '../../Widget/data_empty.dart';

class NotifikasiPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Future<void> _scanQRCode() async {
  //   try {
  //     var result = await BarcodeScanner.scan();
  //     print('Scanned Data: ${result.rawContent}');
  //     // Di sini Anda bisa melakukan sesuatu dengan data yang di-scan
  //   } catch (e) {
  //     print('Error scanning QR code: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Notifikasi'),
          centerTitle: true,
          elevation: double.infinity,
          bottom: const TabBar(tabs: [
            Tab(
              text: 'P3K',
            ),
            Tab(
              text: 'APD',
            ),
          ]),
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        body: const TabBarView(
          children: [P3K(), APD()],
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
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                leading: const Icon(Icons.home),
                title: const Text('Beranda'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Riwayat'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/riwayat');
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifikasi'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profil'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/profil');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text(
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
          currentIndex: 3,
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
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'Scan',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifikasi',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String nama_barang, imgPath, deskripsi, datetime;

  const CardItem(
      {super.key,
      required this.nama_barang,
      required this.imgPath,
      required this.deskripsi,
      required this.datetime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 20, left: 20),
      child: Stack(
        children: [
          Card(
            elevation: 2,
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          imgPath,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 5,
                    child: Text(
                      deskripsi,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 5,
              right: 15,
              child: Text(
                datetime,
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
    ;
  }
}
