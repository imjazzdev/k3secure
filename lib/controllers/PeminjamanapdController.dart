import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/Models/PeminjamanAPD.dart';
import 'package:flutter/material.dart';

class PeminjamanApdController extends GetxController {
  final String apiUrl = 'http://10.127.28.184:8000/api';
  var listPeminjamanApd = <DataPeminjaman>[].obs;

  final TextEditingController npkController = TextEditingController();
  final TextEditingController namaApdController = TextEditingController();
  final TextEditingController jumlahDipinjamController =
      TextEditingController();
  final TextEditingController tanggalPeminjamanController =
      TextEditingController();
  final TextEditingController tanggalPengembalianController =
      TextEditingController();

  Future<bool> addPeminjamanApd(
      String npk,
      String namaApd,
      String jumlahDipinjam,
      DateTime tanggalPeminjaman,
      DateTime tanggalPengembalian) async {
    final response = await http.post(
      Uri.parse('$apiUrl/peminjamanapd'),
      body: {
        'npk': npk,
        'nama_apd': namaApd,
        'jumlah_dipinjam': jumlahDipinjam,
        'tanggal_peminjaman': tanggalPeminjaman.toIso8601String(),
        'tanggal_pengembalian': tanggalPengembalian.toIso8601String(),
      },
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchPeminjamanApdList() async {
    final response = await http.get(Uri.parse('$apiUrl/peminjamanapd'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> dataList = jsonResponse['data'];

      final List<DataPeminjaman> peminjamanApdList =
          dataList.map((data) => DataPeminjaman.fromJson(data)).toList();
      print(peminjamanApdList);

      listPeminjamanApd.assignAll(peminjamanApdList);

      return listPeminjamanApd;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void fetchPeminjamanApdDetail(DataPeminjaman peminjamanApd) {
    npkController.text = peminjamanApd.npk;
    namaApdController.text = peminjamanApd.namaApd;
    jumlahDipinjamController.text = peminjamanApd.jumlahDipinjam;
    tanggalPeminjamanController.text =
        peminjamanApd.tanggalPeminjaman.toIso8601String();
    tanggalPengembalianController.text =
        peminjamanApd.tanggalPengembalian.toIso8601String();
  }

  Future<bool> updatePeminjamanApd(DataPeminjaman peminjamanApd) async {
    final response = await http.put(
      Uri.parse('$apiUrl/peminjamanapd/${peminjamanApd.id}'),
      body: {
        'npk': npkController.text,
        'nama_apd': namaApdController.text,
        'jumlah_dipinjam': jumlahDipinjamController.text,
        'tanggal_peminjaman': tanggalPeminjamanController.text,
        'tanggal_pengembalian': tanggalPengembalianController.text,
      },
    );

    if (response.statusCode == 200) {
      await fetchPeminjamanApdList();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePeminjamanApd(DataPeminjaman peminjamanApd) async {
    final response = await http
        .delete(Uri.parse('$apiUrl/peminjamanapd/${peminjamanApd.id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void clearFields() {
    List<TextEditingController> controllers = [
      npkController,
      namaApdController,
      jumlahDipinjamController,
      tanggalPeminjamanController,
      tanggalPengembalianController,
    ];
    controllers.forEach((controller) => controller.clear());
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchPeminjamanApdList();
  }
}
