import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k3secure/pages/Menu/RiwayatPage/datapeminjamanapdwidget.dart';
import 'package:k3secure/pages/Menu/RiwayatPage/datapenggunaanp3kwidget.dart';

import '../../../constant/constant.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';

class RiwayatPage extends StatelessWidget {
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
          elevation: double.infinity,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: Text('Riwayat'),
          centerTitle: true,
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Penggunaan P3K',
            ),
            Tab(
              text: 'Peminjaman APD',
            ),
          ]),
        ),
        body: TabBarView(
          children: [DataPenggunaanP3KWidget(), DataPeminjamanAPDWidget()],
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
                  Navigator.pop(context); // Close the drawer
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
                  Navigator.pushReplacementNamed(context, '/profil');
                },
              ),
              Divider(), // Pemisah antara menu utama dan Logout
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
          currentIndex: 1, // Highlight Riwayat item
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
      ),
    );
  }
}

class CardItemAPD extends StatelessWidget {
  final String nama_apd, user, tanggal_peminjaman, tanggal_pengembalian;
  final int id, jumlah_peminjaman;
  final String id_ref;

  const CardItemAPD(
      {super.key,
      required this.nama_apd,
      required this.user,
      required this.tanggal_peminjaman,
      required this.tanggal_pengembalian,
      required this.id,
      required this.jumlah_peminjaman,
      required this.id_ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Card(
            elevation: 2,
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Image.asset('assets/apd-${nama_apd}.png')),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     const Text(
                        //       "ID :",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     Text(
                        //       " ${id}",
                        //       style: const TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            const Text(
                              "Nama APD :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${nama_apd}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "User :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${user}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Jumlah Peminjaman :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${jumlah_peminjaman}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Tanggal Peminjaman :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${tanggal_peminjaman}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Tanggal Pengembalian :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${tanggal_pengembalian}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // PopupMenuButton<String>(
                  //   onSelected: (value) {
                  //     if (value == 'edit') {
                  //       controller.npkController.text =
                  //           peminjamanAPD.npk;
                  //       controller.namaApdController.text =
                  //           peminjamanAPD.namaApd;
                  //       controller.jumlahDipinjamController.text =
                  //           peminjamanAPD.jumlahDipinjam;
                  //       controller.tanggalPeminjamanController.text =
                  //           peminjamanAPD.tanggalPeminjaman
                  //               .toIso8601String();
                  //       controller.tanggalPengembalianController.text =
                  //           peminjamanAPD.tanggalPengembalian
                  //               .toIso8601String();
                  //       Get.to(
                  //           () => EditPeminjamanAPDPage(peminjamanAPD));
                  //     } else if (value == 'delete') {
                  //       hapusPeminjamanAPD(peminjamanAPD, context);
                  //     }
                  //   },
                  //   itemBuilder: (BuildContext context) =>
                  //       <PopupMenuEntry<String>>[
                  //     const PopupMenuItem<String>(
                  //       value: 'edit',
                  //       child: Text('Edit'),
                  //     ),
                  //     const PopupMenuItem<String>(
                  //       value: 'delete',
                  //       child: Text('Delete'),
                  //     ),
                  //   ],
                  //   offset: Offset(0, 30),
                  // ),
                ],
              ),
            ),
          ),
          Constant.isAdmin
              ? Positioned(
                  right: 9,
                  top: 7,
                  child: Row(
                    children: [
                      // InkWell(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => EditPeminjamanAPDPage(
                      //                     id: id,
                      //                     user: user,
                      //                     nama_apd: nama_apd,
                      //                     jumlah_peminjaman: jumlah_peminjaman,
                      //                     tanggal_peminjaman:
                      //                         tanggal_peminjaman,
                      //                     tanggal_pengembalian:
                      //                         tanggal_pengembalian,
                      //                   )));
                      //     },
                      //     child: Image.asset(
                      //       'assets/icon-edit.png',
                      //       height: 32,
                      //     )),
                      // const SizedBox(
                      //   width: 7,
                      // ),
                      InkWell(
                          onTap: () {
                            AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.question,
                                    desc: 'Yakin ingin menghapus data ini ?',
                                    btnOkOnPress: () {
                                      FirebaseFirestore.instance
                                          .collection('HISTORY_APD')
                                          .doc(id_ref)
                                          .delete();
                                    },
                                    btnCancelOnPress: () {})
                                .show();
                          },
                          child: Image.asset(
                            'assets/icon-delete.png',
                            height: 23,
                          )),
                    ],
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}

class CardItemP3K extends StatelessWidget {
  final String nama_obat, user, tanggal_penggunaan;
  final int id, jumlah_yang_digunakan;
  final String id_ref;

  const CardItemP3K(
      {super.key,
      required this.nama_obat,
      required this.user,
      required this.tanggal_penggunaan,
      required this.id,
      required this.jumlah_yang_digunakan,
      required this.id_ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Card(
            elevation: 2,
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Image.asset('assets/p3k-${nama_obat}.png')),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     const Text(
                        //       "ID :",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     Text(
                        //       " ${id}",
                        //       style: const TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            Text(
                              "User :",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              " ${user}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Nama Obat :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${nama_obat}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Jumlah Yang Digunakan :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${jumlah_yang_digunakan}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Tanggal Penggunaan :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${tanggal_penggunaan}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Constant.isAdmin
              ? Positioned(
                  right: 9,
                  top: 7,
                  child: Row(
                    children: [
                      // InkWell(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => EditPenggunaanP3KPage(
                      //                   nama_obat: nama_obat,
                      //                   user: user,
                      //                   tanggal_penggunaan: tanggal_penggunaan,
                      //                   id: id,
                      //                   jumlah_yang_digunakan:
                      //                       jumlah_yang_digunakan)));
                      //     },
                      //     child: Image.asset(
                      //       'assets/icon-edit.png',
                      //       height: 32,
                      //     )),
                      // const SizedBox(
                      //   width: 7,
                      // ),
                      InkWell(
                          onTap: () {
                            AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.question,
                                    desc: 'Yakin ingin menghapus data ini ?',
                                    btnOkOnPress: () {
                                      FirebaseFirestore.instance
                                          .collection('HISTORY_P3K')
                                          .doc(id_ref)
                                          .delete();
                                    },
                                    btnCancelOnPress: () {})
                                .show();
                          },
                          child: Image.asset(
                            'assets/icon-delete.png',
                            height: 23,
                          )),
                    ],
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}
