import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/constant/constant.dart';
import 'package:k3secure/controllers/PeminjamanApdController.dart';
import 'package:k3secure/pages/PeminjamanAPD/editpeminjamanapd.dart';
import 'package:k3secure/pages/PeminjamanAPD/tambahpeminjamanapd.dart';
import 'package:k3secure/pages/Widget/data_empty.dart';
import '../../Models/PeminjamanAPD.dart';

class DataPeminjamanAPDPage extends GetView<PeminjamanApdController> {
  Future<void> hapusPeminjamanAPD(
      DataPeminjaman peminjamanapd, BuildContext context) async {
    // Tampilkan dialog konfirmasi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus Data'),
          content: const Text(
              'Apakah Anda yakin ingin menghapus data peminjaman APD ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                final bool berhasil =
                    await controller.deletePeminjamanApd(peminjamanapd);
                Navigator.of(context).pop();

                if (berhasil) {
                  Get.snackbar('Sukses', 'Data peminjaman APD berhasil dihapus',
                      backgroundColor: Colors.green, colorText: Colors.white);
                  // Panggil ulang permintaan data setelah penghapusan
                  await controller.fetchPeminjamanApdList();
                } else {
                  Get.snackbar('Gagal', 'Gagal menghapus data peminjaman APD',
                      backgroundColor: Colors.red, colorText: Colors.white);
                }
              },
              child: const Text('Ya'),
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
        title: const Text('Data Peminjaman APD'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      // body: FutureBuilder(
      //   future: controller.fetchPeminjamanApdList(),
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
      //         itemCount: controller.listPeminjamanApd.length,
      //         itemBuilder: (context, index) {
      //           DataPeminjaman peminjamanAPD =
      //               controller.listPeminjamanApd[index];
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
      //                           peminjamanAPD.npk.substring(0, 1),
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
      //                             peminjamanAPD.npk,
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 16,
      //                             ),
      //                           ),
      //                           SizedBox(height: 8),
      //                           Text(
      //                             "Nama APD: ${peminjamanAPD.namaApd}",
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Jumlah Dipinjam: ${peminjamanAPD.jumlahDipinjam}",
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Tanggal Peminjaman: ${peminjamanAPD.tanggalPeminjaman}",
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Tanggal Pengembalian: ${peminjamanAPD.tanggalPengembalian}",
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
      //                           controller.npkController.text =
      //                               peminjamanAPD.npk;
      //                           controller.namaApdController.text =
      //                               peminjamanAPD.namaApd;
      //                           controller.jumlahDipinjamController.text =
      //                               peminjamanAPD.jumlahDipinjam;
      //                           controller.tanggalPeminjamanController.text =
      //                               peminjamanAPD.tanggalPeminjaman
      //                                   .toIso8601String();
      //                           controller.tanggalPengembalianController.text =
      //                               peminjamanAPD.tanggalPengembalian
      //                                   .toIso8601String();
      //                           Get.to(
      //                               () => EditPeminjamanAPDPage(peminjamanAPD));
      //                         } else if (value == 'delete') {
      //                           hapusPeminjamanAPD(peminjamanAPD, context);
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
          stream: FirebaseFirestore.instance
              .collection('PEMINJAMAN_APD')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data!.docs.isEmpty) {
              return DataEmpty();
            } else {
              return ListView(
                  padding: const EdgeInsets.fromLTRB(18, 25, 18, 20),
                  children: snapshot.data!.docs
                      .map((e) => CardItem(
                            id: e['id'],
                            nama_apd: e['nama_apd'],
                            user: e['user'],
                            jumlah_peminjaman: e['jumlah_peminjaman'],
                            tanggal_peminjaman: e['tanggal_peminjaman'],
                            tanggal_pengembalian: e['tanggal_pengembalian'],
                          ))
                      .toList());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPeminjamanAPDPage());
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
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
    );
  }
}

class CardItem extends StatelessWidget {
  final String nama_apd, user, tanggal_peminjaman, tanggal_pengembalian;
  final int id, jumlah_peminjaman;

  const CardItem(
      {super.key,
      required this.nama_apd,
      required this.user,
      required this.tanggal_peminjaman,
      required this.tanggal_pengembalian,
      required this.id,
      required this.jumlah_peminjaman});

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
                        Row(
                          children: [
                            const Text(
                              "ID :",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " ${id}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPeminjamanAPDPage(
                                          id: id,
                                          user: user,
                                          nama_apd: nama_apd,
                                          jumlah_peminjaman: jumlah_peminjaman,
                                          tanggal_peminjaman:
                                              tanggal_peminjaman,
                                          tanggal_pengembalian:
                                              tanggal_pengembalian,
                                        )));
                          },
                          child: Image.asset(
                            'assets/icon-edit.png',
                            height: 32,
                          )),
                      const SizedBox(
                        width: 7,
                      ),
                      InkWell(
                          onTap: () {
                            AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.question,
                                    desc:
                                        'Yakin ingin menghapus data ID : ${id}',
                                    btnOkOnPress: () {
                                      FirebaseFirestore.instance
                                          .collection('PEMINJAMAN_APD')
                                          .doc(id.toString())
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
