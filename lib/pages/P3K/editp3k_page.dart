import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/Models/Obat.dart';
import 'package:k3secure/controllers/ObatController.dart';

import 'package:k3secure/pages/P3K/datap3k_page.dart';
import 'package:http/http.dart' as http;

class EditP3KPage extends StatefulWidget {
  final String nama, jenis;
  final int jumlah;

  const EditP3KPage(
      {super.key,
      required this.nama,
      required this.jenis,
      required this.jumlah});
  @override
  State<EditP3KPage> createState() => _EditP3KPageState();
}

class _EditP3KPageState extends State<EditP3KPage> {
  // EditP3KPage(this.obat, {super.key});
  final ObatController obatController = Get.find();

  final _formKey = GlobalKey<FormState>();

  Future<bool> updateObat(Obat) async {
    // ignore: unused_local_variable
    final response = await http.put(
      Uri.parse('http://10.127.28.184:8000/api/obat/$Obat'),
      body: {
        'nama_obat': obatController.namaObatController.text,
        'jenis_obat': obatController.jenisObatController.text,
        'stok_obat': obatController.stokObatController.text,
      },
    );
    return true;
  }

  var jumlah = TextEditingController();
  String jenis = '';

  @override
  void initState() {
    jumlah.text = widget.jumlah.toString();
    jenis = widget.jenis;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Obat obat = this.obat;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Edit Data P3K'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 50,
                child: Image.asset('assets/p3k-${widget.nama}.png')),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                            child: Text(
                              widget.nama,
                              style: TextStyle(fontSize: 18),
                            )),
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
                            decoration: const InputDecoration(
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
                            child:
                                Text('Jenis ', style: TextStyle(fontSize: 18))),
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
                                  value: jenis,
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
                                      jenis = val.toString();
                                    });
                                  }),
                            )),
                      ],
                    ),

                    // ListTile(
                    //     leading: const Text('Jenis'),
                    //     title: DropdownButton(
                    //         isExpanded: true,
                    //         value: jenis,
                    //         underline: SizedBox(),
                    //         items: [
                    //           const DropdownMenuItem(
                    //             child: Text('Sekali Pakai'),
                    //             value: 'Sekali Pakai',
                    //           ),
                    //           const DropdownMenuItem(
                    //             child: Text('Berulang Pakai'),
                    //             value: 'Berulang Pakai',
                    //           ),
                    //         ],
                    //         onChanged: (val) {
                    //           setState(() {
                    //             jenis = val.toString();
                    //           });
                    //         })),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // if (_formKey.currentState?.validate() ?? false) {
                //   obatController.updateObat(obat).then((value) {
                //     if (value) {
                //       Get.to(() => DataP3KPage());
                //     } else {
                //       // Penanganan kesalahan jika pembaruan gagal.
                //     }
                //   });
                // }

                AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.question,
                        desc: 'Apakah anda yakin dengan perubahan ini?',
                        btnOkOnPress: () {
                          updateData();
                          Navigator.pop(context);
                        },
                        btnCancelOnPress: () {})
                    .show();
              },
              child: const Text('Update Data P3K'),
            ),
          ],
        ),
      ),
    );
  }

  Future updateData() async {
    final doc = FirebaseFirestore.instance
        .collection('DATA_P3K')
        .doc(widget.nama.toLowerCase());
    doc.update({
      'nama_obat': widget.nama,
      'jenis_obat': jenis,
      'jumlah_obat': int.parse(jumlah.text),
    });
  }
}
