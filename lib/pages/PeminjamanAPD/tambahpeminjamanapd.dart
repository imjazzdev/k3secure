import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k3secure/controllers/PeminjamanApdController.dart';
import 'package:k3secure/pages/PeminjamanAPD/datapeminjamanapd_page.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class AddPeminjamanAPDPage extends StatefulWidget {
  @override
  State<AddPeminjamanAPDPage> createState() => _AddPeminjamanAPDPageState();
}

class _AddPeminjamanAPDPageState extends State<AddPeminjamanAPDPage> {
  final _formKey = GlobalKey<FormState>();

  // Future<void> savePeminjamanAPD() async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     final npk = controller.npkController.text;
  //     final namaApd = controller.namaApdController.text;
  //     final jumlahDipinjam = controller.jumlahDipinjamController.text;
  //     final tanggalPeminjaman = controller.tanggalPeminjamanController.text;
  //     final tanggalPengembalian = controller.tanggalPengembalianController.text;

  //     final response = await http.post(
  //       Uri.parse("http://10.127.28.184:8000/api/peminjamanapd"),
  //       body: {
  //         'npk': npk,
  //         'nama_apd': namaApd,
  //         'jumlah_dipinjam': jumlahDipinjam,
  //         'tanggal_peminjaman': tanggalPeminjaman,
  //         'tanggal_pengembalian': tanggalPengembalian
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       Get.snackbar('Sukses', 'Data Peminjaman APD berhasil ditambahkan',
  //           backgroundColor: Colors.green, colorText: Colors.white);
  //       // Navigasi ke halaman DataPenggunaanP3KPage setelah menampilkan Snackbar
  //       Get.to(() => DataPeminjamanAPDPage());
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       print('Respons: ${response.body}');
  //       Get.snackbar('Gagal', 'Gagal menambahkan Data Peminjaman APD',
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   }
  var uuid = Uuid();

  var id_peminjaman = TextEditingController(text: '0');
  var email = TextEditingController(text: 'example@gmail.com');
  var nama_apd = 'Helm';
  var jumlah_peminjaman = TextEditingController(text: '1');
  var tanggal_peminjaman =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  var tanggal_pengembalian =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // controller.npkController.clear();
    // controller.namaApdController.clear();
    // controller.jumlahDipinjamController.clear();
    // controller.tanggalPeminjamanController.clear();
    // controller.tanggalPengembalianController.clear();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Tambah Peminjaman APD'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 50,
                        child: Image.asset('assets/apd-${nama_apd}.png'),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width: 50, child: Text('ID :')),
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: id_peminjaman,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: 'Masukan ID',
                                              suffixIcon: Icon(
                                                Icons.edit,
                                                size: 20,
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Tolong masukan data";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width: 50, child: Text('Email :')),
                                    Expanded(
                                      child: SizedBox(
                                        height: 25,
                                        child: TextFormField(
                                          controller: email,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            suffixIcon: Icon(
                                              Icons.edit,
                                              size: 20,
                                            ),
                                            // hintText: 'Masukan email',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Tolong masukan data";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width: 100, child: Text('Nama APD :')),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          value: nama_apd,
                                          underline: const SizedBox(),
                                          items: const [
                                            DropdownMenuItem(
                                              child: Text('Helm'),
                                              value: 'Helm',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Penutup Telinga'),
                                              value: 'Penutup Telinga',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Rompi'),
                                              value: 'Rompi',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Sepatu'),
                                              value: 'Sepatu',
                                            ),
                                          ],
                                          onChanged: (val) {
                                            setState(() {
                                              nama_apd = val.toString();
                                            });
                                          }),
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width: 170,
                                        child: Text('Jumlah Peminjaman :')),
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: jumlah_peminjaman,
                                          keyboardType: TextInputType.number,
                                          cursorHeight: 20,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              suffixIcon: Icon(
                                                Icons.edit,
                                                size: 20,
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Tolong masukan data";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width: 185,
                                        child: Text('Tanggal Peminjaman :')),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(tanggal_peminjaman),
                                        IconButton(
                                            onPressed: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2023),
                                                      lastDate: DateTime(2100));

                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(pickedDate);

                                                setState(() {
                                                  tanggal_peminjaman =
                                                      formattedDate; //set output date to TextField value.
                                                });
                                              } else {}
                                            },
                                            icon: const Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey,
                                            ))
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width: 185,
                                        child: Text('Tanggal Pengembalian :')),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(tanggal_pengembalian),
                                        IconButton(
                                            onPressed: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2023),
                                                      lastDate: DateTime(2100));

                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(pickedDate);

                                                setState(() {
                                                  tanggal_pengembalian =
                                                      formattedDate; //set output date to TextField value.
                                                });
                                              } else {}
                                            },
                                            icon: const Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey,
                                            ))
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // if (_formKey.currentState?.validate() ?? false) {
                          //   peminjamanApdController
                          //       .updatePeminjamanApd(peminjamanApd)
                          //       .then((value) {
                          //     if (value) {
                          //       Get.to(() => DataPeminjamanAPDPage());
                          //     } else {
                          //       // Penanganan kesalahan jika pembaruan gagal.
                          //     }
                          //   });
                          // }
                          tambahData();
                          await Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              setState(() {
                                isLoading = false;
                              });
                            },
                          );
                          // ignore: use_build_context_synchronously
                        },
                        child: const Text('Tambah Data Peminjaman APD'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          isLoading == false
              ? const SizedBox()
              : const Center(
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

  Future tambahData() async {
    setState(() {
      isLoading = true;
    });

    final docPeminjamanAPD = await FirebaseFirestore.instance
        .collection('PEMINJAMAN_APD')
        .doc(id_peminjaman.text);

    final docHistory = await FirebaseFirestore.instance
        .collection('HISTORY_APD')
        .doc(uuid.v1().toString());

    final snapshot = await FirebaseFirestore.instance
        .collection('PEMINJAMAN_APD')
        .doc(id_peminjaman.text)
        .get();

    final docDataAPD = FirebaseFirestore.instance
        .collection('DATA_APD')
        .doc(nama_apd.toLowerCase());

    if (snapshot.exists) {
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.warning,
        title: 'ID (${id_peminjaman.text}) sudah terdaftar!',
        btnOkOnPress: () {},
      ).show();
    } else {
      var getJumlah = docDataAPD.get().then((value) async {
        Map data = value.data() as Map;

        if (int.parse(data['jumlah_apd'].toString()) == 0) {
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            desc: 'Tidak bisa meminjam. $nama_apd saat ini tidak tersedia',
            btnOkOnPress: () {},
          ).show();
        } else if (int.parse(jumlah_peminjaman.text) >
            int.parse(data['jumlah_apd'].toString())) {
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.warning,
            desc:
                '$nama_apd tersedia saat ini sejumlah ${data['jumlah_apd'].toString()}. Jangan meminjam lebih dari stok tersedia',
            btnOkOnPress: () {},
          ).show();
        } else {
          docDataAPD.update({
            // 'nama_apd': valnama,
            // 'kondisi_apd': valkondisi,
            'jumlah_apd': (int.parse(data['jumlah_apd'].toString()) -
                int.parse(jumlah_peminjaman.text)),
          });

          final order = PeminjamanAPDModel(
            id: int.parse(id_peminjaman.text),
            user: email.text,
            nama_apd: nama_apd,
            jumlah_peminjaman: int.parse(jumlah_peminjaman.text),
            tanggal_peminjaman: tanggal_peminjaman,
            tanggal_pengembalian: tanggal_pengembalian,
          );
          final json = order.toJson();
          await docPeminjamanAPD.set(json);

          final history = PeminjamanAPDModel(
            id: 0,
            user: email.text,
            nama_apd: nama_apd,
            jumlah_peminjaman: int.parse(jumlah_peminjaman.text),
            tanggal_peminjaman: tanggal_peminjaman,
            tanggal_pengembalian: tanggal_pengembalian,
          );
          final jsonHistory = history.toJson();
          await docHistory.set(jsonHistory);

          //popup berhasil menambahkan data
          // ignore: use_build_context_synchronously
          AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.success,
                  desc: 'Data berhasil ditambahkan',
                  btnOkOnPress: () {
                    Navigator.pop(context);
                  },
                  btnCancelOnPress: () {})
              .show();
        }
      });
    }
  }
}

class PeminjamanAPDModel {
  final String user, nama_apd, tanggal_peminjaman, tanggal_pengembalian;
  final int id, jumlah_peminjaman;

  PeminjamanAPDModel(
      {required this.user,
      required this.nama_apd,
      required this.tanggal_peminjaman,
      required this.tanggal_pengembalian,
      required this.id,
      required this.jumlah_peminjaman});

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'nama_apd': nama_apd,
        'jumlah_peminjaman': jumlah_peminjaman,
        'tanggal_peminjaman': tanggal_peminjaman,
        'tanggal_pengembalian': tanggal_pengembalian,
      };
}
