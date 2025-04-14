import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeController extends ValueNotifier<ThemeMode> {
  static const _key = 'isDarkMode';

  ThemeController() : super(ThemeMode.light) {
    _loadTheme(); // ← при запуске контроллера подгружаем сохранённую тему
  }
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? false;
    value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, mode == ThemeMode.dark);
  }

  void toggleTheme() {
    final isDark = value == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    value = newMode;
    _saveTheme(newMode);
  }
}