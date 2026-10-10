import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SettingsService extends ChangeNotifier{
  static const _themeKey = 'is_dark';

  ThemeMode _themeMode =ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> toggleTheme() async {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final dark = prefs.getBool(_themeKey) ?? true;
    _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    _vibrationEnabled = prefs.getBool(_vibrationKey) ?? true;

    _keepScreenOn = prefs.getBool(_keepScreenOnKey) ?? false;
    WakelockPlus.toggle(enable: _keepScreenOn);
    notifyListeners();
  }
  static const _vibrationKey = 'vibration_enabled';

  bool _vibrationEnabled = true;
  bool get vibrationEnabled => _vibrationEnabled;

  Future<void> setVibration(bool value) async {
    _vibrationEnabled = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_vibrationKey, value);
  }
  static const _keepScreenOnKey = 'keep_screen_on';

  bool _keepScreenOn = false;
  bool get keepScreenOn => _keepScreenOn;

  Future<void> setKeepScreenOn(bool value) async {
    _keepScreenOn = value;
    WakelockPlus.toggle(enable: value);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keepScreenOnKey, value);
  }
}