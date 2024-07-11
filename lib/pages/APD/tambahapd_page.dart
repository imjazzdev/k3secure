import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k3secure/controllers/apdcontroller.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/pages/APD/dataapd_page.dart';

import '../../Models/Notifikasi.dart';

class AddAPDPage extends StatefulWidget {
  @override
  State<AddAPDPage> createState() => _AddAPDPageState();
}

class _AddAPDPageState extends State<AddAPDPage> {
  // final _formKey = GlobalKey<FormState>();

  // Future saveAPD() async {
  //   final response =
  //       await http.post(Uri.parse("http://10.127.28.184:8000/api/apd"), body: {
  //     "nama_apd": controller.namaApdController.text,
  //     "kondisi_apd": controller.kondisiApdController.text,
  //     "stok_apd": controller.stokApdController.text,
  //   });

  //   return json.decode(response.body);
  // }

  String? valnama = 'Helm';
  var jumlah = TextEditingController(text: '0');
  String valkondisi = 'Baik';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // controller.clearFields();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('Tambah Data APD'),
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
                  Icons.warning_rounded,
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
                  padding: const EdgeInsets.all(20),
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
                                      child: Text('Helm'),
                                      value: 'Helm',
                                    ),
                                    const DropdownMenuItem(
                                      child: Text('Penutup Telinga'),
                                      value: 'Penutup Telinga',
                                    ),
                                    const DropdownMenuItem(
                                      child: Text('Rompi'),
                                      value: 'Rompi',
                                    ),
                                    const DropdownMenuItem(
                                      child: Text('Sepatu'),
                                      value: 'Sepatu',
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
                              child: Text('Kondisi',
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
                                      value: valkondisi,
                                      underline: SizedBox(),
                                      items: [
                                        const DropdownMenuItem(
                                          child: Text('Baik'),
                                          value: 'Baik',
                                        ),
                                        const DropdownMenuItem(
                                          child: Text('Buruk'),
                                          value: 'Buruk',
                                        ),
                                      ],
                                      onChanged: (val) {
                                        setState(() {
                                          valkondisi = val.toString();
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
                  //   saveAPD().then((value) => {Get.to(() => DataAPDPage())});
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
                child: Text('Tambah Data APD'),
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

    final doc = await FirebaseFirestore.instance
        .collection('DATA_APD')
        .doc(valnama!.toLowerCase());

    var getJumlah = doc.get().then((value) {
      Map data = value.data() as Map;
      // print(data['jumlah_apd']);
      doc.update({
        'nama_apd': valnama,
        'kondisi_apd': valkondisi,
        'jumlah_apd':
            (int.parse(data['jumlah_apd'].toString()) + int.parse(jumlah.text)),
      });
    });

    final not = FirebaseFirestore.instance.collection('NOTIFIKASI').doc(
          DateFormat('dd-MM-yyyy - HH:mm:ss').format(DateTime.now()).toString(),
        );

    final notif = NotifikasiModel(
        nama_barang: valnama.toString(),
        deskripsi: '$valnama telah ditambahkan to Data APD',
        datetime: DateFormat('dd-MM-yyyy - HH:mm:ss')
            .format(DateTime.now())
            .toString(),
        kategori: 'APD');
    final json = notif.toJson();
    await not.set(json);
  }
}
