// /lib/theme/app_theme:dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TreeZooAppTheme {
  static ThemeData get lightTheme {
    // カスタムカラースキームを使用
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 97, 161, 124), // 明るい緑
        secondary: Color.fromARGB(255, 139, 195, 143), // 明るいオレンジ
        surface: Colors.white,
        background: Colors.white,
        error: Color.fromARGB(255, 179, 64, 56),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      textTheme: GoogleFonts.mPlusRounded1cTextTheme(),
    );
  }

  static ThemeData get darkTheme {
    // Dark theme settings
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Colors.blueGrey, // 濃い灰色
        secondary: Colors.tealAccent, // 明るい水色
        surface: Color.fromARGB(255, 18, 32, 47),
        background: Color.fromARGB(255, 13, 23, 35),
        error: Color.fromARGB(255, 179, 64, 56),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      textTheme: GoogleFonts.mPlusRounded1cTextTheme(),
    );
  }
}
