// /lib/theme/app_theme:dart
import 'package:flutter/material.dart';

class TreeZooAppTheme {
  static ThemeData get lightTheme {
    // Light theme settings
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromARGB(255, 122, 236, 207),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    // Dark theme settings (example)
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
