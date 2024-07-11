import 'package:get/get.dart';
import 'package:k3secure/helper/preference.dart';
import 'package:k3secure/pages/Menu/dashboard_page.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var checkAuth = await Preference.getAuth();
    print(checkAuth);
    if (checkAuth != null) {
      Get.to(DashboardPage());
    }
  }
}
