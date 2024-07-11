import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


Future<bool> login(String npk, String password) async {
  try {
    // Lakukan logika autentikasi di sini, misalnya dengan mengirimkan permintaan HTTP ke server Anda.
    // Jika login berhasil, server Anda dapat mengirimkan token atau data pengguna dalam respons.
    final response = await http.post(
      Uri.parse('http://10.127.28.142:8000/api/login'), 
      body: {
        'npk': npk,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Autentikasi berhasil, Anda dapat mengambil token atau data pengguna dari respons.
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? token = responseData['auth_token']; // Ganti 'token' dengan kunci respons yang sesuai

      // Jika Anda ingin menyimpan data pengguna juga:
      final Map<String, dynamic>? userData = responseData['npk']; // Ganti 'user' dengan kunci respons yang sesuai
      final String? npk = userData?['npk']; // Ganti 'name' dengan kunci yang sesuai

      // Simpan informasi sesi ke shared_preferences:
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', token!); // Simpan token
      prefs.setString('npk', npk!); // Simpan NPK pengguna

      return true; // Berhasil login
    } else {
      return false; // Gagal login, misalnya karena NPK atau kata sandi salah
    }
  } catch (e) {
    // Tangani kesalahan autentikasi di sini, misalnya jika tidak dapat terhubung ke server
    print('Kesalahan autentikasi: $e');
    return false; // Gagal login karena kesalahan
  }
}

