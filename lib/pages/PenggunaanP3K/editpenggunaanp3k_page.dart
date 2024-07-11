import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k3secure/Models/PenggunaanP3K.dart';
import 'package:k3secure/controllers/PenggunaanP3KController.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/pages/PenggunaanP3K/datapenggunaanp3k_page.dart';

class EditPenggunaanP3KPage extends StatefulWidget {
  final String nama_obat, user, tanggal_penggunaan;
  final int id, jumlah_yang_digunakan;

  const EditPenggunaanP3KPage(
      {super.key,
      required this.nama_obat,
      required this.user,
      required this.tanggal_penggunaan,
      required this.id,
      required this.jumlah_yang_digunakan});

  // EditPenggunaanP3KPage(this.penggunaanP3K, {Key? key}) : super(key: key);
  // final DataPenggunaanP3K penggunaanP3K;

  @override
  State<EditPenggunaanP3KPage> createState() => _EditPenggunaanP3KPageState();
}

class _EditPenggunaanP3KPageState extends State<EditPenggunaanP3KPage> {
  // final PenggunaanP3KController penggunaanP3KController = Get.find();

  // final _formKey = GlobalKey<FormState>();

  // Future<bool> updatePenggunaanP3K(DataPenggunaanP3K penggunaanP3K) async {
  //   final response = await http.put(
  //     Uri.parse(
  //         'http://10.127.28.184:8000/api/penggunaanp3k/${penggunaanP3K.id}'),
  //     body: {
  //       'npk': penggunaanP3KController.npkController.text,
  //       'nama_obat': penggunaanP3KController.namaObatController.text,
  //       'jumlah_digunakan':
  //           penggunaanP3KController.jumlahDigunakanController.text,
  //       'tanggal_penggunaan':
  //           penggunaanP3KController.tanggalPenggunaanController.text,
  //     },
  //   );

  //   return response.statusCode == 200;
  // }
  var id = TextEditingController();
  var email = TextEditingController();
  var nama_obat = '';
  var jumlah_yang_digunakan = TextEditingController();
  var tanggal_penggunaan = '';

  @override
  void initState() {
    id.text = widget.id.toString();
    email.text = widget.user;
    nama_obat = widget.nama_obat;
    jumlah_yang_digunakan.text = widget.jumlah_yang_digunakan.toString();
    tanggal_penggunaan = widget.tanggal_penggunaan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DataPenggunaanP3K penggunaanP3K = this.widget.penggunaanP3K;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('Edit Penggunaan P3K'),
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
                                const SizedBox(width: 50, child: Text('ID :')),
                                Expanded(
                                  child: SizedBox(
                                    height: 25,
                                    child: TextFormField(
                                      controller: id,
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
                                      value: nama_obat,
                                      underline: const SizedBox(),
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
                                Container(
                                    // color: Colors.amber,
                                    width: 250,
                                    child: Text('Jumlah Yang Digunakan :')),
                                Expanded(
                                  child: SizedBox(
                                    height: 25,
                                    child: TextFormField(
                                      controller: jumlah_yang_digunakan,
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
                                                  initialDate: DateTime.now(),
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
        .collection('PENGGUNAAN_P3K')
        .doc(widget.id.toString());
    doc.update({
      'id': int.parse(widget.id.toString()),
      'user': email.text,
      'nama_obat': nama_obat,
      'jumlah_yang_digunakan': int.parse(jumlah_yang_digunakan.text),
      'tanggal_penggunaan': tanggal_penggunaan,
    });
  }
}
