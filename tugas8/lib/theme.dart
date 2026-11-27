import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  String _userName = '';
  String get userName => _userName;

  static const _themekey = 'theme_key';
  static const _namekey = 'user_name';

  ThemeProvider() {
    _loadData();
  }

  // Memuat tema dan nama sekaligus saat aplikasi dibuka
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool(_themekey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    _userName = prefs.getString(_namekey) ?? '';

    notifyListeners();
  }

  Future<void> toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themekey, isOn);
  }

  Future<void> saveUserName(String name) async {
    _userName = name.trim();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_namekey, _userName);
  }
}