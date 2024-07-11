import 'dart:convert';
import 'package:k3secure/Models/Auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/constant.dart';

class Preference {
  static Future setAuth(Auth user) async {
    final p = await prefs;
    return p.setString(Constant.authPrefrence, jsonEncode(user.toJson()));
  }

  static Future<Auth?> getAuth() async {
    final p = await prefs;

    final userJson = p.getString(Constant.authPrefrence);
    if (userJson == null) {
      return null;
    }

    final userMap = json.decode(userJson);
    final user = Auth.fromJson(userMap);

    return user;
  }

  static Future<bool> remove(String key) async {
    final p = await prefs;
    return p.remove(key);
  }

  static Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  static Future setBool(String key, bool? value) async {
    final p = await prefs;
    return p.setBool(key, value!);
  }

  static Future<int> getInt(String key) async {
    final p = await prefs;
    return p.getInt(key) ?? 0;
  }

  static Future setInt(String key, int? value) async {
    final p = await prefs;
    return p.setInt(key, value!);
  }

  static Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key) ?? '';
  }

  static Future setString(String key, String? value) async {
    final p = await prefs;
    return p.setString(key, value!);
  }

  static Future<double> getDouble(String key) async {
    final p = await prefs;
    return p.getDouble(key) ?? 0.0;
  }

  static Future setDouble(String key, double? value) async {
    final p = await prefs;
    return p.setDouble(key, value!);
  }

  // helper

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
