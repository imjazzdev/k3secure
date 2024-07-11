import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyController extends GetxController {
  final String baseUrl = 'http://10.127.28.184:8000/api';
  String? authToken;

  @override
  void onInit() {
    super.onInit();
    loadTokenFromStorage();
  }

  Future<void> loadTokenFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('jwtToken');
  }

  Future<void> fetchData() async {
    final headers = {'Authorization': 'Bearer $authToken'};

    final response = await http.get(
      Uri.parse('$baseUrl/some_endpoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      json.decode(response.body);
      // Lakukan sesuatu dengan responseData jika diperlukan
    } else {
      // Tangani jika respons tidak berhasil
    }
  }
}
