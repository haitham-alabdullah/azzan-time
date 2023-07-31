import 'package:flutter/material.dart';

class Themes {
  static const Color primary = Color(0xFFEAE2D6);
  static const Color textColor = Color(0xFF533E3C);
  static const Color bg = Color(0xFFEAE2D6);

  static const textStyle = TextStyle(
    fontFamily: 'Tajawal',
  );

  static ThemeData themeData = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: primary),
    appBarTheme: const AppBarTheme(
      backgroundColor: bg,
      foregroundColor: textColor,
    ),
    splashColor: primary,
    highlightColor: Colors.black12,
    scaffoldBackgroundColor: bg,
  );

  static List<BoxShadow> cardShadow() {
    return [];
  }
}
