import 'package:get/get.dart';
import 'package:k3secure/controllers/apdcontroller.dart';
import 'package:k3secure/controllers/ObatController.dart';
import 'package:k3secure/controllers/PeminjamanApdController.dart';
import 'package:k3secure/controllers/PenggunaanP3KController.dart';

class K3SecureBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObatController>(() => ObatController());
    Get.lazyPut<apdcontroller>(() => apdcontroller());
    Get.lazyPut<PenggunaanP3KController>(() => PenggunaanP3KController());
    Get.lazyPut<PeminjamanApdController>(() => PeminjamanApdController());
  }
}
