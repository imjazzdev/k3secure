import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/Models/Obat.dart';

class ObatController extends GetxController {
  final String apiUrl = 'http://10.127.28.184:8000/api';
  var listObat = <Obat>[].obs;

  final TextEditingController namaObatController = TextEditingController();
  final TextEditingController jenisObatController = TextEditingController();
  final TextEditingController stokObatController = TextEditingController();

  Future<bool> addObat(
      String namaObat, String jenisObat, String stokObat) async {
    final response = await http.post(
      Uri.parse('$apiUrl/obat'),
      body: {
        'nama': namaObat,
        'jenis': jenisObat,
        'stok': stokObat,
      },
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchObatList() async {
    final response = await http.get(Uri.parse('$apiUrl/obat'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> dataList = jsonResponse['data'];

      final List<Obat> obatList =
          dataList.map((data) => Obat.fromJson(data)).toList();
      print(obatList);

      listObat.assignAll(obatList);

      // final List<dynamic> responseData = json.decode(response.body)['data'];

      // Uncomment this line to return the list of obat
      // return responseData.map((data) => Data.fromJson(data)).toList();

      // Return the list of obat
      return listObat;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void fetchObatDetail(Obat obat) {
    namaObatController.text = obat.namaObat;
    jenisObatController.text = obat.jenisObat;
    stokObatController.text = obat.stokObat;
  }

  Future<bool> updateObat(Obat obat) async {
    final response = await http.put(
      Uri.parse(
          '$apiUrl/obat/${obat.id}'), // Ubah ini sesuai dengan data yang ingin Anda perbarui
      body: {
        'nama_obat': namaObatController.text,
        'jenis_obat': jenisObatController.text,
        'stok_obat': stokObatController.text,
      },
    );

    if (response.statusCode == 200) {
      // Perubahan berhasil disimpan di backend
      // Ambil data terbaru dari backend dan perbarui listObat
      await fetchObatList(); // Misalnya, Anda memiliki metode fetchObatList yang mengambil data dari server
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteObat(Obat obat) async {
    final response = await http.delete(Uri.parse('$apiUrl/obat/${obat.id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void clearFields() {
    List<TextEditingController> controllers = [
      namaObatController,
      jenisObatController,
      stokObatController,
    ];
    controllers.forEach((controller) => controller.clear());
  }

  @override
  void onInit() async {
    print("call onInit"); // this line not printing
    // checkIsLogin();
    // print("ww");
    super.onInit();
    await fetchObatList();
  }
}

class Data {
  Data.fromJson(Map<String, dynamic> json) {}
}
