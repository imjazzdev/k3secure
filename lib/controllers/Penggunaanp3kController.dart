import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/Models/PenggunaanP3K.dart';
import 'package:flutter/material.dart';

class PenggunaanP3KController extends GetxController {
  final String apiUrl = 'http://10.127.28.184:8000/api';
  var listPenggunaanP3K = <DataPenggunaanP3K>[].obs;

  final TextEditingController npkController = TextEditingController();
  final TextEditingController namaObatController = TextEditingController();
  final TextEditingController jumlahDigunakanController =
      TextEditingController();
  final TextEditingController tanggalPenggunaanController =
      TextEditingController();

  void clearFields() {
    List<TextEditingController> controllers = [
      npkController,
      namaObatController,
      jumlahDigunakanController,
      tanggalPenggunaanController,
    ];
    controllers.forEach((controller) => controller.clear());
  }

  Future<bool> addPenggunaanP3K(String npk, String namaObat,
      String jumlahDigunakan, DateTime tanggalPenggunaan) async {
    final response = await http.post(
      Uri.parse('$apiUrl/penggunaanp3k'),
      body: {
        'npk': npk,
        'nama_obat': namaObat,
        'jumlah_digunakan': jumlahDigunakan,
        'tanggal_penggunaan': tanggalPenggunaan.toIso8601String(),
      },
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchPenggunaanP3KList() async {
    final response = await http.get(Uri.parse('$apiUrl/penggunaanp3k'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> dataList = jsonResponse['data'];

      final List<DataPenggunaanP3K> penggunaanP3KList =
          dataList.map((data) => DataPenggunaanP3K.fromJson(data)).toList();
      print(penggunaanP3KList);

      listPenggunaanP3K.assignAll(penggunaanP3KList);

      // final List<dynamic> responseData = json.decode(response.body)['data'];

      // Uncomment this line to return the list of penggunaanP3K
      // return responseData.map((data) => Data.fromJson(data)).toList();

      // Return the list of penggunaanP3K
      return listPenggunaanP3K;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void fetchPenggunaanP3KDetail(DataPenggunaanP3K penggunaanP3K) {
    npkController.text = penggunaanP3K.npk;
    namaObatController.text = penggunaanP3K.namaObat;
    jumlahDigunakanController.text = penggunaanP3K.jumlahDigunakan;
    tanggalPenggunaanController.text =
        penggunaanP3K.tanggalPenggunaan.toIso8601String();
  }

  Future<bool> updatePenggunaanP3K(DataPenggunaanP3K penggunaanP3K) async {
    final response = await http.put(
      Uri.parse('$apiUrl/penggunaanp3k/${penggunaanP3K.id}'),
      body: {
        'npk': npkController.text,
        'nama_obat': namaObatController.text,
        'jumlah_digunakan': jumlahDigunakanController.text,
        'tanggal_penggunaan': tanggalPenggunaanController.text,
      },
    );

    if (response.statusCode == 200) {
      // Perubahan berhasil disimpan di backend
      // Ambil data terbaru dari backend dan perbarui listPenggunaanP3K
      await fetchPenggunaanP3KList(); // Misalnya, Anda memiliki metode fetchPenggunaanP3KList yang mengambil data dari server
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePenggunaanP3K(DataPenggunaanP3K penggunaanP3K) async {
    final response = await http
        .delete(Uri.parse('$apiUrl/penggunaanp3k/${penggunaanP3K.id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() async {
    print("call onInit"); // this line not printing
    // checkIsLogin();
    // print("ww");
    super.onInit();
    await fetchPenggunaanP3KList();
  }
}
