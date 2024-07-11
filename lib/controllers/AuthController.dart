import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:k3secure/Models/Auth.dart';
import 'package:k3secure/helper/preference.dart';

class AuthController extends GetxController {
  final TextEditingController npkController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final baseUrl = 'http://10.127.28.184:8000/api';
  RxBool isLoggedIn = false.obs;

  Future<bool> login(String npk, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {'npk': npk, 'password': password},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          // Jika login berhasil
          isLoggedIn.value = true;

          // Simpan data otentikasi dalam preferensi
          final authData = Auth.fromJson(responseData['data']);
          await Preference.setAuth(authData);

          return true;
        } else {
          // Jika login gagal (misalnya, data login tidak cocok)
          return false;
        }
      } else {
        // Jika terjadi masalah dengan panggilan API
        return false;
      }
    } catch (e) {
      print('Error in login: $e');
      return false;
    }
  }

  Future<bool> register(String npk, String nama, String role, String password,
      String kontak) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: {
          'npk': npk,
          'nama': nama,
          'role': role,
          'password': password,
          'kontak': kontak,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error in registration: $e');
      return false;
    }
  }
}
