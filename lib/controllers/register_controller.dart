import 'package:get/get.dart';
import 'package:k3secure/services/api_service.dart';

class RegisterController extends GetxController {
  final ApiService apiService =
      ApiService(baseUrl: 'http://10.127.28.184:8000/api');

  var npk = ''.obs;
  var nama = ''.obs;
  var role = ''.obs;
  var password = ''.obs;
  var kontak = ''.obs;

  var isLoggedIn = false.obs;

  Future<void> register() async {
    try {
      final response = await apiService.post('register', {
        'npk': npk.value,
        'nama': nama.value,
        'role': role.value,
        'password': password.value,
        'kontak': kontak.value,
      });
      if (response['success']) {
        isLoggedIn.value = true;
      } else {
        isLoggedIn.value = false;
      }
    } catch (e) {
      isLoggedIn.value = false;
    }
  }
}
