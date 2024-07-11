import 'package:get/get.dart';
import 'package:k3secure/bindings/k3secure_bindings.dart';
import 'package:k3secure/bindings/welcomepage_bindings.dart';
import 'package:k3secure/pages/APD/dataapd_page.dart';
import 'package:k3secure/pages/AuthPage/auth_page.dart';
import 'package:k3secure/pages/AuthPage/login_page.dart';
import 'package:k3secure/pages/Menu/dashboard_page.dart';
import 'package:k3secure/pages/Menu/Notifikasi/notifikasi_page.dart';
import 'package:k3secure/pages/Menu/profil_page.dart';
import 'package:k3secure/pages/Menu/qrcode_page.dart';
import 'package:k3secure/pages/Menu/RiwayatPage/riwayat_page.dart';
import 'package:k3secure/pages/P3K/datap3k_page.dart';
import 'package:k3secure/pages/P3K/tambahp3k_page.dart';
import 'package:k3secure/pages/PeminjamanAPD/datapeminjamanapd_page.dart';
import 'package:k3secure/pages/PenggunaanP3K/datapenggunaanp3k_page.dart';
import 'package:k3secure/pages/welcome_page.dart';
import '../pages/AuthPage/register_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
      name: _Paths.WelcomePage,
      page: () => WelcomePage(),
      binding: WelcomePageBinding(),
    ),
    GetPage(
      name: _Paths.AuthPage,
      page: () => AuthPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.LoginPage,
      page: () => LoginPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.RegisterPage,
      page: () => RegisterPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.DashboardPage,
      page: () => DashboardPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.RiwayatPage,
      page: () => RiwayatPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.NotifikasiPage,
      page: () => NotifikasiPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.QRCodePage,
      page: () => QRCodePage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.ProfilPage,
      page: () => ProfilPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.DataP3KPage,
      page: () => DataP3KPage(),
      binding: K3SecureBindings(),
    ),
    // GetPage(
    //   name: _Paths.EditP3KPage,
    //   page: () => EditP3KPage(),
    //   binding: K3SecureBindings(),
    // ),
    GetPage(
      name: _Paths.AddP3KPage,
      page: () => AddP3KPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.DataAPDPage,
      page: () => DataAPDPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.DataPenggunaanP3KPage,
      page: () => DataPenggunaanP3KPage(),
      binding: K3SecureBindings(),
    ),
    GetPage(
      name: _Paths.DataPeminjamanAPDPage,
      page: () => DataPeminjamanAPDPage(),
      binding: K3SecureBindings(),
    ),
  ];
}
