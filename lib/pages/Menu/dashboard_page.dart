import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:k3secure/constant/constant.dart';

import 'package:k3secure/helper/preference.dart';
import 'package:k3secure/pages/AuthPage/auth_page.dart';

import '../../data/firebase_api.dart';

void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => DashboardPage(),
      '/login': (context) => AuthPage(),
    });
  }
}

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'hight_important_channel', 'TITLE',
      importance: Importance.high, playSound: true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateToMenuItem(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/datap3k');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/dataapd');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/penggunaanp3k');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/peminjamanapd');
    }
  }

  void _navigateToProfilePage(BuildContext context) {
    Navigator.pushNamed(context, '/profil');
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Future getDataUser() async {
  //   var user = await FirebaseFirestore.instance
  //       .collection('DATA_PEGAWAI')
  //       .doc(Constant.EMAIL)
  //       .get();
  //   Constant.USERNAME = user['nama'].toString();
  //   Constant.TELP = user['telp'].toString();
  //   Constant.EMAIL = user['email'].toString();
  //   print('USER LOGIN');
  //   print(Constant.USERNAME);
  //   print(Constant.EMAIL);
  //   print('Status Admin : ${Constant.isAdmin}');
  // }

  @override
  void initState() {
    // getDataUser();

    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     FirebaseAPI().flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //             android: AndroidNotificationDetails(
    //                 FirebaseAPI().channel.id, FirebaseAPI().channel.name,
    //                 color: Colors.blue,
    //                 playSound: true,
    //                 icon: '@mipmap/ic_launcher')));
    //   }
    // });
  }

  // Future<void> _scanQRCode() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: double.infinity,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _navigateToProfilePage(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/th_2.jpg'),
                radius: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: FutureBuilder(
                future: Preference.getAuth(),
                builder: (context, snapshot) {
                  var auth = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/th_2.jpg'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        Constant.isAdmin ? 'Admin' : 'Pegawai',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${FirebaseAuth.instance.currentUser!.email}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      // Text(
                      //   '${auth?.npk}',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 15,
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Beranda',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(
                'Riwayat',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/riwayat');
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text(
                'Notifikasi',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/notifikasi');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Profil',
                style: TextStyle(fontSize: 18),
              ),
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
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40), // Spasi ke atas
          const Text(
            'K3SECURE',
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 36,
              color: Colors.blueAccent,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToMenuItem(context, index);
                    },
                    child: MenuCard(
                      imageAsset: menuItems[index].imageAsset,
                      title: menuItems[index].title,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            // Riwayat
            Navigator.pushReplacementNamed(context, '/riwayat');
          } else if (index == 2) {
            // Qr Code
            Navigator.pushReplacementNamed(context, '/qrcode');
          } else if (index == 3) {
            // Handle Notifikasi
            Navigator.pushReplacementNamed(context, '/notifikasi');
          } else if (index == 4) {
            // Handle Notifikasi
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
            icon: Icon(Icons.qr_code), // Gunakan ikon yang sesuai
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
    );
  }
}

class MenuCard extends StatelessWidget {
  final String imageAsset;
  final String title;

  const MenuCard({
    required this.imageAsset,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAsset,
            width: 96,
            height: 96,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String imageAsset;
  final String title;

  MenuItem({
    required this.imageAsset,
    required this.title,
  });
}

final List<MenuItem> menuItems = [
  MenuItem(imageAsset: 'assets/DataP3K.png', title: 'Data P3K'),
  MenuItem(imageAsset: 'assets/DataAPD.jpg', title: 'Data APD'),
  MenuItem(imageAsset: 'assets/DataPenggunaanP3K.png', title: 'Penggunaan P3K'),
  MenuItem(imageAsset: 'assets/DataPeminjamanAPD.png', title: 'Peminjaman APD'),
];
