import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/Models/Apd.dart';
import 'package:k3secure/controllers/apdcontroller.dart';
import 'package:k3secure/pages/APD/dataapd_page.dart';
import 'package:http/http.dart' as http;

class EditAPDPage extends StatefulWidget {
  final String nama, kondisi;
  final int jumlah;

  const EditAPDPage(
      {super.key,
      required this.nama,
      required this.kondisi,
      required this.jumlah});

  @override
  State<EditAPDPage> createState() => _EditAPDPageState();
}

class _EditAPDPageState extends State<EditAPDPage> {
  final apdcontroller apdController = Get.find();

  final _formKey = GlobalKey<FormState>();

  // Future<bool> updateApd(Apd apd) async {
  //   // ignore: unused_local_variable
  //   final response = await http.put(
  //     Uri.parse('http://10.127.28.184:8000/api/${apd.id}'),
  //     body: {
  //       'nama_apd': apdController.namaApdController.text,
  //       'kondisi_apd': apdController.kondisiApdController.text,
  //       'stok_apd': apdController.stokApdController.text,
  //     },
  //   );

  //   return true;
  // }

  var jumlah = TextEditingController();
  String valkondisi = 'Baik';

  @override
  void initState() {
    jumlah.text = widget.jumlah.toString();
    valkondisi = widget.kondisi;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('Edit Data APD'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 50,
                child: Image.asset('assets/apd-${widget.nama}.png')),
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
                            child: Text('Kondisi ',
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
                                  }),
                            )),
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
                //   apdController.updateApd(widget.apd).then((value) {
                //     if (value) {
                //       Get.to(() => DataAPDPage());
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
                // updateData();
              },
              child: Text('Update Data APD'),
            ),
          ],
        ),
      ),
    );
  }

  Future updateData() async {
    final doc = FirebaseFirestore.instance
        .collection('DATA_APD')
        .doc(widget.nama.toLowerCase());
    doc.update({
      'nama_apd': widget.nama,
      'kondisi_apd': valkondisi,
      'jumlah_apd': int.parse(jumlah.text),
    });
  }
}
