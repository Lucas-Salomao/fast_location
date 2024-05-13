import 'package:flutter/material.dart'; // Importa o framework Flutter para desenvolvimento de interface.

// Define a classe ThemeModel que gerencia o tema do aplicativo.
class ThemeModel extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light; // Define o tema atual como claro por padrão.

  // Getter para obter o tema atual.
  ThemeMode get currentTheme => _currentTheme;

  // Alterna o tema entre claro e escuro.
  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }

  // Define o tema como claro.
  void setLightTheme() {
    _currentTheme = ThemeMode.light;
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }

  // Define o tema como escuro.
  void setDarkTheme() {
    _currentTheme = ThemeMode.dark;
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }
}
