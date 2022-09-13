import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDark = false;
  ThemeMode get currentMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  static get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Color.fromARGB(255, 0, 89, 148),
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black87,
        primaryVariant: Color.fromARGB(255, 2, 63, 104),
        secondaryVariant: Colors.black,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Colors.grey,
        onSurface: Colors.grey,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }

  static get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Color.fromARGB(255, 1, 53, 48),
        onPrimary: Colors.white,
        secondary: Colors.black87,
        onSecondary: Colors.white,
        primaryVariant: Colors.white,
        secondaryVariant: Color.fromARGB(255, 6, 100, 92),
        background: Color.fromARGB(255, 47, 192, 180),
        onBackground: Colors.white,
        surface: Colors.grey,
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
    );
  }
}
