import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharedPreferencesHelper {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<ThemeMode> getThemeMode() async {
    final SharedPreferences prefs = await _prefs;
    final savedThemeMode = prefs.getInt('themeMode') ?? 0;
    return ThemeMode.values[savedThemeMode];
  }

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt('themeMode', themeMode.index);
  }
}
