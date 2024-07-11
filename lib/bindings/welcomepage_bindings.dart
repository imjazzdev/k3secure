import 'package:get/get.dart';
import 'package:k3secure/controllers/AuthController.dart';
import 'package:k3secure/controllers/WelcomeController.dart';

class WelcomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
