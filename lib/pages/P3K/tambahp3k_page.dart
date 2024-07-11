import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k3secure/controllers/ObatController.dart';
import 'package:k3secure/pages/P3K/datap3k_page.dart';
import 'package:http/http.dart' as http;

import '../../Models/Notifikasi.dart';

class AddP3KPage extends StatefulWidget {
  @override
  State<AddP3KPage> createState() => _AddP3KPageState();
}

class _AddP3KPageState extends State<AddP3KPage> {
  String? valnama = 'Alkohol';
  TextEditingController jumlah = TextEditingController(text: '0');
  String valjenis = 'Sekali Pakai';

  bool isLoading = false;
  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // controller.clearFields();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('Tambah Data P3K'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 50,
                child: Icon(
                  Icons.medical_services,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
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
                                'Nama ',
                                style: TextStyle(fontSize: 18),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                ':',
                                style: TextStyle(fontSize: 18),
                              )),
                          Expanded(
                              flex: 6,
                              child: DropdownButton(
                                  isExpanded: true,
                                  value: valnama,
                                  underline: SizedBox(),
                                  items: [
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
                                      valnama = val.toString();
                                    });
                                  })),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text('Jumlah ',
                                  style: TextStyle(fontSize: 18))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                ':',
                                style: TextStyle(fontSize: 18),
                              )),
                          Expanded(
                            flex: 6,
                            child: TextFormField(
                              controller: jumlah,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  // hintText: 'Input Stok',
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Tolong Masukkan Jumlah Stok Tersedia";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text('Jenis ',
                                  style: TextStyle(fontSize: 18))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                ':',
                                style: TextStyle(fontSize: 18),
                              )),
                          Expanded(
                              flex: 6,
                              child: SizedBox(
                                  height: 30,
                                  child: DropdownButton(
                                      isExpanded: true,
                                      value: valjenis,
                                      underline: SizedBox(),
                                      items: [
                                        const DropdownMenuItem(
                                          child: Text('Sekali Pakai'),
                                          value: 'Sekali Pakai',
                                        ),
                                        const DropdownMenuItem(
                                          child: Text('Berulang Pakai'),
                                          value: 'Berulang Pakai',
                                        ),
                                      ],
                                      onChanged: (val) {
                                        setState(() {
                                          valjenis = val.toString();
                                        });
                                      }))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // if (_formKey.currentState?.validate() ?? false) {
                  //   saveObat().then((value) => {Get.to(() => DataP3KPage())});
                  // }
                  tambahData();
                  await Future.delayed(
                    Duration(seconds: 2),
                    () {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  );
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
                },
                child: Text('Tambah Data P3K'),
              ),
            ],
          ),
          isLoading == false
              ? SizedBox()
              : Center(
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
    final doc = FirebaseFirestore.instance
        .collection('DATA_P3K')
        .doc(valnama!.toLowerCase());

    var getJumlah = doc.get().then((value) {
      Map data = value.data() as Map;
      // print(data['jumlah_apd']);
      doc.update({
        'nama_obat': valnama,
        'jenis_obat': valjenis,
        'jumlah_obat': (int.parse(data['jumlah_obat'].toString()) +
            int.parse(jumlah.text)),
      });
    });

    final not = FirebaseFirestore.instance.collection('NOTIFIKASI').doc(
          DateFormat('dd-MM-yyyy - HH:mm:ss').format(DateTime.now()).toString(),
        );

    final notif = NotifikasiModel(
        nama_barang: valnama.toString(),
        deskripsi: '$valnama telah ditambahkan to Data P3K',
        datetime: DateFormat('dd-MM-yyyy - HH:mm:ss')
            .format(DateTime.now())
            .toString(),
        kategori: 'P3K');
    final json = notif.toJson();
    await not.set(json);
  }
}
