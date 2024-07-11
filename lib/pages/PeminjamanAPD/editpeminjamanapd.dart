import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k3secure/Models/PeminjamanAPD.dart';
import 'package:k3secure/controllers/PeminjamanApdController.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/pages/PeminjamanAPD/datapeminjamanapd_page.dart';

class EditPeminjamanAPDPage extends StatefulWidget {
  final String nama_apd, user, tanggal_peminjaman, tanggal_pengembalian;
  final int id, jumlah_peminjaman;

  const EditPeminjamanAPDPage(
      {super.key,
      required this.nama_apd,
      required this.user,
      required this.tanggal_peminjaman,
      required this.tanggal_pengembalian,
      required this.id,
      required this.jumlah_peminjaman});
  @override
  State<EditPeminjamanAPDPage> createState() => _EditPeminjamanAPDPageState();
}

class _EditPeminjamanAPDPageState extends State<EditPeminjamanAPDPage> {
  // EditPeminjamanAPDPage(this.peminjamanApd, {Key? key}) : super(key: key);
  var id_peminjaman = TextEditingController();
  var email = TextEditingController();
  var nama_apd = '';
  var jumlah_peminjaman = TextEditingController();
  var tanggal_peminjaman = '';
  var tanggal_pengembalian = '';

  @override
  void initState() {
    id_peminjaman.text = widget.id.toString();
    email.text = widget.user;
    nama_apd = widget.nama_apd;
    jumlah_peminjaman.text = widget.jumlah_peminjaman.toString();
    tanggal_peminjaman = widget.tanggal_peminjaman;
    tanggal_pengembalian = widget.tanggal_pengembalian;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DataPeminjaman peminjamanApd = this.peminjamanApd;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Edit Peminjaman APD'),
      ),
      body: Column(
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
                                const SizedBox(width: 50, child: Text('ID :')),
                                Expanded(
                                  child: SizedBox(
                                    height: 25,
                                    child: TextFormField(
                                      controller: id_peminjaman,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        // labelText: 'ID',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
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
                                        // labelText: 'email',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
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
                                    height: 25,
                                    child: TextFormField(
                                      controller: jumlah_peminjaman,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: Icon(
                                            Icons.edit,
                                            size: 20,
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
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
                                                  initialDate: DateTime.now(),
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
                                                  initialDate: DateTime.now(),
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
                    child: const Text('Update Peminjaman APD'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future updateData() async {
    final doc = FirebaseFirestore.instance
        .collection('PEMINJAMAN_APD')
        .doc(widget.id.toString());
    doc.update({
      'id': int.parse(id_peminjaman.text),
      'user': email.text,
      'nama_apd': nama_apd,
      'jumlah_peminjaman': int.parse(jumlah_peminjaman.text),
      'tanggal_peminjaman': tanggal_peminjaman,
      'tanggal_pengembalian': tanggal_pengembalian,
    });
  }
}
