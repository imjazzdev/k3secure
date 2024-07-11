import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k3secure/controllers/PenggunaanP3KController.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/pages/PenggunaanP3K/datapenggunaanp3k_page.dart';
import 'package:uuid/uuid.dart';

class AddPenggunaanP3KPage extends StatefulWidget {
  @override
  State<AddPenggunaanP3KPage> createState() => _AddPenggunaanP3KPageState();
}

class _AddPenggunaanP3KPageState extends State<AddPenggunaanP3KPage> {
  final _formKey = GlobalKey<FormState>();

  // Future<void> savePenggunaanP3K() async {
  var uuid = Uuid();

  var id = TextEditingController(text: '0');
  var email = TextEditingController(text: 'example@gmail.com');
  var nama_obat = 'Alkohol';
  var jumlah_yang_digunakan = TextEditingController(text: '1');
  var tanggal_penggunaan =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // controller.npkController.clear();
    // controller.namaObatController.clear();
    // controller.jumlahDigunakanController.clear();
    // controller.tanggalPenggunaanController.clear();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('Tambah Penggunaan P3K'),
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
                        child: Image.asset('assets/p3k-${nama_obat}.png'),
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
                                          controller: id,
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
                                        width: 100, child: Text('Nama Obat :')),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          value: nama_obat,
                                          underline: const SizedBox(),
                                          items: const [
                                            const DropdownMenuItem(
                                              child: Text('Alkohol'),
                                              value: 'Alkohol',
                                            ),
                                            const DropdownMenuItem(
                                              child: Text('Betadine'),
                                              value: 'Betadine',
                                            ),
                                            const DropdownMenuItem(
                                              child: Text('Paracetamol'),
                                              value: 'Paracetamol',
                                            ),
                                            const DropdownMenuItem(
                                              child: Text('Plester'),
                                              value: 'Plester',
                                            ),
                                          ],
                                          onChanged: (val) {
                                            setState(() {
                                              nama_obat = val.toString();
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
                                        width: 200,
                                        child: Text('Jumlah Yang Digunakan :')),
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: jumlah_yang_digunakan,
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
                                        child: Text('Tanggal Penggunaan :')),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(tanggal_penggunaan),
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
                                                  tanggal_penggunaan =
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
                        child: const Text('Tambah Data Penggunaan P3K'),
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

    final docPenggunaanP3K = await FirebaseFirestore.instance
        .collection('PENGGUNAAN_P3K')
        .doc(id.text);

    final docHistory = await FirebaseFirestore.instance
        .collection('HISTORY_P3K')
        .doc(uuid.v1().toString());

    final snapshot = await FirebaseFirestore.instance
        .collection('PENGGUNAAN_P3K')
        .doc(id.text)
        .get();

    final docDataP3K = FirebaseFirestore.instance
        .collection('DATA_P3K')
        .doc(nama_obat.toLowerCase());

    if (snapshot.exists) {
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.warning,
        title: 'ID (${id.text}) sudah terdaftar!',
        btnOkOnPress: () {},
      ).show();
    } else {
      var getJumlah = docDataP3K.get().then((value) async {
        Map data = value.data() as Map;

        if (int.parse(data['jumlah_obat'].toString()) == 0) {
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            desc: 'Tidak bisa digunakan. $nama_obat saat ini tidak tersedia',
            btnOkOnPress: () {},
          ).show();
        } else if (int.parse(jumlah_yang_digunakan.text) >
            int.parse(data['jumlah_obat'].toString())) {
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.warning,
            desc:
                '$nama_obat tersedia saat ini sejumlah ${data['jumlah_obat'].toString()}. Jangan menggunakan obat lebih dari stok yang tersedia',
            btnOkOnPress: () {},
          ).show();
        } else {
          docDataP3K.update({
            // 'nama_apd': valnama,
            // 'kondisi_apd': valkondisi,
            'jumlah_obat': (int.parse(data['jumlah_obat'].toString()) -
                int.parse(jumlah_yang_digunakan.text)),
          });

          final order = PenggunaanP3KModel(
            id: int.parse(id.text),
            user: email.text,
            nama_obat: nama_obat,
            jumlah_yang_digunakan: int.parse(jumlah_yang_digunakan.text),
            tanggal_penggunaan: tanggal_penggunaan,
          );
          final json = order.toJson();
          await docPenggunaanP3K.set(json);

          final history = PenggunaanP3KModel(
            id: 0,
            user: email.text,
            nama_obat: nama_obat,
            jumlah_yang_digunakan: int.parse(jumlah_yang_digunakan.text),
            tanggal_penggunaan: tanggal_penggunaan,
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

class PenggunaanP3KModel {
  final String user, nama_obat, tanggal_penggunaan;
  final int id, jumlah_yang_digunakan;

  PenggunaanP3KModel(
      {required this.user,
      required this.nama_obat,
      required this.tanggal_penggunaan,
      required this.id,
      required this.jumlah_yang_digunakan});

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'nama_obat': nama_obat,
        'jumlah_yang_digunakan': jumlah_yang_digunakan,
        'tanggal_penggunaan': tanggal_penggunaan,
      };
}
