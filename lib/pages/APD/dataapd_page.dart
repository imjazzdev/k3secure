import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/constant/constant.dart';
import 'package:k3secure/controllers/apdcontroller.dart';
import 'package:k3secure/pages/APD/editapd_page.dart';
import 'package:k3secure/pages/APD/tambahapd_page.dart';

class DataAPDPage extends GetView<apdcontroller> {
  // Future<void> hapusApd(Apd _apd, BuildContext context) async {
  //   // Tampilkan dialog konfirmasi
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Konfirmasi Hapus Data'),
  //         content: Text('Apakah Anda yakin ingin menghapus data APD ini?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Tutup dialog
  //             },
  //             child: Text('Tidak'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               final bool berhasil = await controller.deleteApd(_apd);
  //               Navigator.of(context).pop(); // Tutup dialog

  //               if (berhasil) {
  //                 Get.snackbar('Sukses', 'Data APD berhasil dihapus',
  //                     backgroundColor: Colors.green, colorText: Colors.white);
  //                 // Panggil ulang permintaan data setelah penghapusan
  //                 await controller.fetchApdList();
  //               } else {
  //                 Get.snackbar('Gagal', 'Gagal menghapus data APD',
  //                     backgroundColor: Colors.red, colorText: Colors.white);
  //               }
  //             },
  //             child: Text('Ya'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Data APD'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      // body: FutureBuilder(
      //   future: controller.fetchApdList(),
      //   initialData: [],
      //   builder: (context, AsyncSnapshot snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: Text("No data"),
      //       );
      //     }

      //     return Obx(() {
      //       return ListView.builder(
      //         itemCount: controller.listApd.length,
      //         itemBuilder: (context, index) {
      //           Apd apd = controller.listApd[index];
      //           return Container(
      //             margin: EdgeInsets.only(top: 10),
      //             child: Card(
      //               elevation: 2,
      //               color: Colors.blue,
      //               child: Container(
      //                 width: double.infinity,
      //                 padding: EdgeInsets.all(16),
      //                 child: Row(
      //                   children: [
      //                     Container(
      //                       width: 50,
      //                       height: 50,
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         shape: BoxShape.circle,
      //                       ),
      //                       child: Center(
      //                         child: Text(
      //                           apd.namaApd.substring(0, 1),
      //                           style: TextStyle(
      //                             color: Colors.blue,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(width: 16),
      //                     Expanded(
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             apd.namaApd,
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 16,
      //                             ),
      //                           ),
      //                           SizedBox(height: 8),
      //                           Text(
      //                             "Kondisi APD: ${apd.kondisiApd}",
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Jumlah Stok Tersedia: ${apd.stokApd}",
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     PopupMenuButton<String>(
      //                       onSelected: (value) {
      //                         if (value == 'edit') {
      //                           controller.namaApdController.text = apd.namaApd;
      //                           controller.kondisiApdController.text =
      //                               apd.kondisiApd;
      //                           controller.stokApdController.text = apd.stokApd;
      //                           Get.to(() => EditAPDPage(apd));
      //                         } else if (value == 'delete') {
      //                           hapusApd(apd, context);
      //                         }
      //                       },
      //                       itemBuilder: (BuildContext context) =>
      //                           <PopupMenuEntry<String>>[
      //                         const PopupMenuItem<String>(
      //                           value: 'edit',
      //                           child: Text('Edit'),
      //                         ),
      //                         const PopupMenuItem<String>(
      //                           value: 'delete',
      //                           child: Text('Delete'),
      //                         ),
      //                       ],
      //                       offset: Offset(0, 30),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     });
      //   },
      // ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('DATA_APD').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs
                    .map((e) => CardItem(
                        nama_apd: e['nama_apd'],
                        kondisi_apd: e['kondisi_apd'],
                        jumlah_apd: e['jumlah_apd']))
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
                Get.to(() => AddAPDPage());
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
  final String nama_apd, kondisi_apd;
  final int jumlah_apd;

  const CardItem(
      {super.key,
      required this.nama_apd,
      required this.kondisi_apd,
      required this.jumlah_apd});

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
                        "assets/apd-${nama_apd}.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama_apd,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        jumlah_apd == 0
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
                        Row(
                          children: [
                            Text(
                              "Kondisi : ",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            kondisi_apd == 'Baik'
                                ? Text(
                                    "${kondisi_apd}",
                                    style:
                                        TextStyle(color: Colors.green.shade400),
                                  )
                                : Text(
                                    "${kondisi_apd}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      jumlah_apd.toString(),
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
                  right: 9,
                  top: 9,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAPDPage(
                                  nama: nama_apd,
                                  kondisi: kondisi_apd,
                                  jumlah: jumlah_apd),
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
