import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k3secure/constant/constant.dart';
import 'package:k3secure/pages/PenggunaanP3K/editpenggunaanp3k_page.dart';
import 'package:k3secure/pages/PenggunaanP3K/exportpdfp3k.dart';
import 'package:k3secure/pages/PenggunaanP3K/tambahpenggunaanp3k_page.dart';
import 'package:k3secure/pages/Widget/data_empty.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../Models/PenggunaanP3K.dart';

class DataPenggunaanP3KPage extends StatefulWidget {
  @override
  State<DataPenggunaanP3KPage> createState() => _DataPenggunaanP3KPageState();
}

class _DataPenggunaanP3KPageState extends State<DataPenggunaanP3KPage> {
  Future<void> hapusPenggunaanP3K(
      DataPenggunaanP3K penggunaanP3K, BuildContext context) async {
    // Tampilkan dialog konfirmasi
  }

  var chooseMonthYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Data Penggunaan P3K'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              chooseMonthYear = await showMonthYearPicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2027),
                  initialMonthYearPickerMode: MonthYearPickerMode.month);
              if (chooseMonthYear != null) {
                chooseMonthYear =
                    DateFormat('dd-MM-yyyy').format(chooseMonthYear);

                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ExportPdfP3K(monthYear: chooseMonthYear.toString()),
                    ));
              }
            },
            icon: Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
            ),
          ),
        ],
      ),
      // body: FutureBuilder(
      //   future: controller.fetchPenggunaanP3KList(),
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
      //         itemCount: controller.listPenggunaanP3K.length,
      //         itemBuilder: (context, index) {
      //           DataPenggunaanP3K penggunaanP3K =
      //               controller.listPenggunaanP3K[index];
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
      //                           penggunaanP3K.npk.substring(0, 1),
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
      //                             penggunaanP3K.npk,
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 16,
      //                             ),
      //                           ),
      //                           SizedBox(height: 8),
      //                           Text(
      //                             "Nama Obat: ${penggunaanP3K.namaObat}",
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Jumlah Digunakan: ${penggunaanP3K.jumlahDigunakan}",
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Tanggal Penggunaan: ${penggunaanP3K.tanggalPenggunaan}",
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
      //                               penggunaanP3K.npk;
      //                           controller.namaObatController.text =
      //                               penggunaanP3K.namaObat;
      //                           controller.jumlahDigunakanController.text =
      //                               penggunaanP3K.jumlahDigunakan;
      //                           controller.tanggalPenggunaanController.text =
      //                               penggunaanP3K.tanggalPenggunaan
      //                                   .toIso8601String();
      //                           Get.to(
      //                               () => EditPenggunaanP3KPage(penggunaanP3K));
      //                         } else if (value == 'delete') {
      //                           hapusPenggunaanP3K(penggunaanP3K, context);
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
              .collection('PENGGUNAAN_P3K')
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
                            nama_obat: e['nama_obat'],
                            user: e['user'],
                            jumlah_yang_digunakan: e['jumlah_yang_digunakan'],
                            tanggal_penggunaan: e['tanggal_penggunaan'],
                          ))
                      .toList());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPenggunaanP3KPage());
        },
        child: Icon(Icons.add),
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
  final String nama_obat, user, tanggal_penggunaan;
  final int id, jumlah_yang_digunakan;

  const CardItem(
      {super.key,
      required this.nama_obat,
      required this.user,
      required this.tanggal_penggunaan,
      required this.id,
      required this.jumlah_yang_digunakan});

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
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPenggunaanP3KPage(
                                        nama_obat: nama_obat,
                                        user: user,
                                        tanggal_penggunaan: tanggal_penggunaan,
                                        id: id,
                                        jumlah_yang_digunakan:
                                            jumlah_yang_digunakan)));
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
                                          .collection('PENGGUNAAN_P3K')
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
