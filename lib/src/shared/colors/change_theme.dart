import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light;

  ThemeMode get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme =
    _currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setLightTheme() {
    _currentTheme = ThemeMode.light;
    notifyListeners();
  }

  void setDarkTheme() {
    _currentTheme = ThemeMode.dark;
    notifyListeners();
  }
}