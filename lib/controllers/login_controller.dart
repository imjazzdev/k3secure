import 'package:get/get.dart';
import 'package:k3secure/services/api_service.dart';

class LoginController extends GetxController {
  final ApiService apiService =
      ApiService(baseUrl: 'http://10.127.28.184:8000/api');

  var isLoggedIn = false.obs;
  var npk = ''.obs;
  var password = ''.obs;

  Future<void> login() async {
    try {
      final response = await apiService
          .post('login', {'npk': npk.value, 'password': password.value});
      if (response['success']) {
        isLoggedIn.value = true;
        Get.offAllNamed('/dashboard');
      } else {
        isLoggedIn.value = false;
      }
    } catch (e) {
      isLoggedIn.value = false;
    }
  }

  void logout() {
    isLoggedIn.value = false;
  }
}
