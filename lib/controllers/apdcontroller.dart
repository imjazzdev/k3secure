import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/Models/Apd.dart';

class apdcontroller extends GetxController {
  final String apiUrl = 'http://10.127.28.184:8000/api';
  var listApd = <Apd>[].obs;

  final TextEditingController namaApdController = TextEditingController();
  final TextEditingController kondisiApdController = TextEditingController();
  final TextEditingController stokApdController = TextEditingController();

  Future<bool> addApd(String namaApd, String kondisiApd, String stokApd) async {
    final response = await http.post(
      Uri.parse('$apiUrl/apd'),
      body: {
        'nama_apd': namaApd,
        'kondisi_apd': kondisiApd,
        'stok_apd': stokApd,
      },
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchApdList() async {
    final response = await http.get(Uri.parse('$apiUrl/apd'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> dataList = jsonResponse['data'];

      final List<Apd> apdList =
          dataList.map((data) => Apd.fromJson(data)).toList();
      print(apdList);

      listApd.assignAll(apdList);

      return listApd;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void fetchApdDetail(Apd apd) {
    namaApdController.text = apd.namaApd;
    kondisiApdController.text = apd.kondisiApd;
    stokApdController.text = apd.stokApd;
  }

  Future<bool> updateApd(Apd apd) async {
    final response = await http.put(
      Uri.parse('$apiUrl/apd/${apd.id}'),
      body: {
        'nama_apd': namaApdController.text,
        'kondisi_apd': kondisiApdController.text,
        'stok_apd': stokApdController.text,
      },
    );

    if (response.statusCode == 200) {
      await fetchApdList();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteApd(Apd apd) async {
    final response = await http.delete(Uri.parse('$apiUrl/apd/${apd.id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void clearFields() {
    List<TextEditingController> controllers = [
      namaApdController,
      kondisiApdController,
      stokApdController,
    ];
    controllers.forEach((controller) => controller.clear());
  }

  @override
  void onInit() async {
    print("call onInit");
    super.onInit();
    await fetchApdList();
  }
}
