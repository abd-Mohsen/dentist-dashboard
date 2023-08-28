import 'package:flutter/material.dart';

///custom themes

class MyThemes {
  TextTheme tt = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      wordSpacing: 64,
      letterSpacing: 0,
      // Customize displayLarge style...
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      wordSpacing: 52,
      letterSpacing: 0,
      // Customize displayMedium style...
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      wordSpacing: 44,
      letterSpacing: 0,
      // Customize displaySmall style...
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      wordSpacing: 40,
      letterSpacing: 0,
      // Customize headlineLarge style...
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      wordSpacing: 36,
      letterSpacing: 0,
      // Customize headlineMedium style...
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      wordSpacing: 32,
      letterSpacing: 0,
      // Customize headlineSmall style...
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      wordSpacing: 28,
      letterSpacing: 0,
      // Customize titleLarge style...
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      wordSpacing: 24,
      letterSpacing: 0.15,
      // Customize titleMedium style...
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      wordSpacing: 20,
      letterSpacing: 0.1,
      // Customize titleSmall style...
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      wordSpacing: 20,
      letterSpacing: 0.1,
      // Customize labelLarge style...
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      wordSpacing: 16,
      letterSpacing: 0.5,
      // Customize labelMedium style...
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      wordSpacing: 16,
      letterSpacing: 0.5,
      // Customize labelSmall style...
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      wordSpacing: 24,
      letterSpacing: 0.15,
      // Customize bodyLarge style...
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      wordSpacing: 20,
      letterSpacing: 0.25,
      // Customize bodyMedium style...
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      wordSpacing: 16,
      letterSpacing: 0.4,
      // Customize bodySmall style...
    ),
  );

  static ThemeData myDarkMode = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffBB86FC),
      onPrimary: Colors.white,
      secondary: Color(0xff03DAC6),
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white70,
      background: Color(0xff121212),
      onBackground: Color(0xffA4A4A4),
      surface: Color(0xff1e1e1e),
      onSurface: Color(0xffD7D7D7),
    ),
  );

  static ThemeData myLightMode = ThemeData.light().copyWith(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1c1c1c),
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white70,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );
}
