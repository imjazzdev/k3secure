import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/constant/constant.dart';
import 'package:k3secure/controllers/ObatController.dart';
import 'package:k3secure/pages/P3K/editp3k_page.dart';
import 'package:k3secure/pages/P3K/tambahp3k_page.dart';

import '../../Models/Obat.dart';

class DataP3KPage extends GetView<ObatController> {
  Future<void> hapusObat(Obat obat, BuildContext context) async {
    // Tampilkan dialog konfirmasi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus Data'),
          content: Text('Apakah Anda yakin ingin menghapus data obat ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                final bool berhasil = await controller.deleteObat(obat);
                Navigator.of(context).pop(); // Tutup dialog

                if (berhasil) {
                  Get.snackbar('Sukses', 'Data obat berhasil dihapus',
                      backgroundColor: Colors.green, colorText: Colors.white);
                  // Panggil ulang permintaan data setelah penghapusan
                  await controller.fetchObatList();
                } else {
                  Get.snackbar('Gagal', 'Gagal menghapus data obat',
                      backgroundColor: Colors.red, colorText: Colors.white);
                }
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Data P3K'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('DATA_P3K').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs
                    .map((e) => CardItem(
                        nama_obat: e['nama_obat'],
                        jenis_obat: e['jenis_obat'],
                        jumlah_obat: e['jumlah_obat']))
                    .toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: Constant.isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => AddP3KPage());
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            )
          : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

class CardItem extends StatelessWidget {
  final String nama_obat, jenis_obat;
  final int jumlah_obat;

  const CardItem(
      {super.key,
      required this.nama_obat,
      required this.jenis_obat,
      required this.jumlah_obat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, right: 20, left: 20),
      child: Stack(
        children: [
          Card(
            elevation: 2,
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/p3k-${nama_obat}.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama_obat,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        jumlah_obat == 0
                            ? Text(
                                'Tidak Tersedia',
                                style: TextStyle(
                                    color: Colors.red,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 5,
                                          color: Colors.grey,
                                          offset: Offset(1, 2))
                                    ],
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                'Tersedia',
                                style: TextStyle(
                                    color: Colors.green.shade400,
                                    fontWeight: FontWeight.bold),
                              ),
                        Text(
                          "Jenis : ${jenis_obat}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      jumlah_obat.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // PopupMenuButton<String>(
                  //   onSelected: (value) {
                  //     // if (value == 'edit') {
                  //     //   controller.namaObatController.text =
                  //     //       obat.namaObat;
                  //     //   controller.jenisObatController.text =
                  //     //       obat.jenisObat;
                  //     //   controller.stokObatController.text =
                  //     //       obat.stokObat;
                  //     //   Get.to(() => EditP3KPage(obat));
                  //     // } else if (value == 'delete') {
                  //     //   hapusObat(obat, context);
                  //     // }
                  //   },
                  //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
                  right: 10,
                  top: 10,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditP3KPage(
                                  nama: nama_obat,
                                  jenis: jenis_obat,
                                  jumlah: jumlah_obat),
                            ));
                      },
                      child: Image.asset('assets/icon-edit.png')))
              : SizedBox()
        ],
      ),
    );
    ;
  }
}
