part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const WelcomePage = _Paths.WelcomePage;
  static const AuthPage = _Paths.AuthPage;
  static const LoginPage = _Paths.LoginPage;
  static const RegisterPage = _Paths.RegisterPage;
  static const DashboardPage = _Paths.DashboardPage;
  static const RiwayatPage = _Paths.RiwayatPage;
  static const NotifikasiPage = _Paths.NotifikasiPage;
  static const QRCodePage = _Paths.QRCodePage;
  static const DataP3KPage = _Paths.DataP3KPage;
  static const EditP3KPage = _Paths.EditP3KPage;
  static const AddP3KPage = _Paths.AddP3KPage;
  static const DataAPDPage = _Paths.DataAPDPage;
  static const AddAPDPage = _Paths.AddAPDPage;
  static const EditAPDPage = _Paths.EditAPDPage;
  static const DataPenggunaanP3KPage = _Paths.DataPenggunaanP3KPage;
  static const EditPenggunaanP3KPage = _Paths.EditPenggunaanP3KPage;
  static const AddPenggunaanP3KPage = _Paths.AddPenggunaanP3KPage;
  static const PeminjamanAPDPage = _Paths.DataPeminjamanAPDPage;
  static const EditPeminjamanAPDPage = _Paths.EditPeminjamanAPDPage;
  static const AddPeminjamanAPDPage = _Paths.AddPeminjamanAPDPage;
}

abstract class _Paths {
  _Paths._();
  static const WelcomePage = '/';
  static const AuthPage = '/auth';
  static const LoginPage = '/login';
  static const RegisterPage = '/register';
  static const DashboardPage = '/dashboard';
  static const RiwayatPage = '/riwayat';
  static const NotifikasiPage = '/notifikasi';
  static const QRCodePage = '/qrcode';
  static const ProfilPage = '/profil';
  static const DataP3KPage = '/datap3k';
  static const EditP3KPage = '/editp3k';
  static const AddP3KPage = '/addp3k';
  static const DataAPDPage = '/dataapd';
  static const AddAPDPage = '/addapd';
  static const EditAPDPage = '/editapd';
  static const DataPenggunaanP3KPage = '/penggunaanp3k';
  static const EditPenggunaanP3KPage = '/editpenggunaanp3k';
  static const AddPenggunaanP3KPage = '/addpenggunaanp3k';
  static const DataPeminjamanAPDPage = '/peminjamanapd';
  static const EditPeminjamanAPDPage = '/editpeminjamanapd';
  static const AddPeminjamanAPDPage = '/addpeminjamanapd';
}
