import 'package:flutter/material.dart';
import 'package:get/get.dart';

///custom themes

class MyThemes {
  TextTheme tt = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      wordSpacing: 64,
      letterSpacing: 0,
      fontFamily: 'arabic',
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      wordSpacing: 52,
      letterSpacing: 0,
      fontFamily: 'arabic',
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      wordSpacing: 44,
      letterSpacing: 0,
      fontFamily: 'arabic',
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      wordSpacing: 40,
      letterSpacing: 0,
      fontFamily: 'arabic',
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      wordSpacing: 36,
      letterSpacing: 0,
      fontFamily: 'arabic',
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      wordSpacing: 32,
      letterSpacing: 0,
      fontFamily: 'arabic',
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      wordSpacing: 28,
      letterSpacing: 0,
      fontFamily: 'arabic',
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      wordSpacing: 24,
      letterSpacing: 0.15,
      fontFamily: 'arabic',
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      wordSpacing: 20,
      letterSpacing: 0.1,
      fontFamily: 'arabic',
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      wordSpacing: 20,
      letterSpacing: 0.1,
      fontFamily: 'arabic',
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      wordSpacing: 16,
      letterSpacing: 0.5,
      fontFamily: 'arabic',
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      wordSpacing: 16,
      letterSpacing: 0.5,
      fontFamily: 'arabic',
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      wordSpacing: 24,
      letterSpacing: 0.15,
      fontFamily: 'arabic',
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      wordSpacing: 20,
      letterSpacing: 0.25,
      fontFamily: 'arabic',
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      wordSpacing: 16,
      letterSpacing: 0.4,
      fontFamily: 'arabic',
    ),
  );

  static ThemeData myDarkMode = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff02979D),
      onPrimary: Colors.black,
      secondary: Color(0xff03DAC6),
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white70,
      background: Color(0xff121212),
      onBackground: Color(0xffA4A4A4),
      surface: Color(0xff1e1e1e),
      onSurface: Color(0xffD7D7D7),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        wordSpacing: 64,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        wordSpacing: 52,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        wordSpacing: 44,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        wordSpacing: 40,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        wordSpacing: 36,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        wordSpacing: 32,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        wordSpacing: 28,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        wordSpacing: 24,
        letterSpacing: 0.15,
        fontFamily: 'arabic',
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        wordSpacing: 20,
        letterSpacing: 0.1,
        fontFamily: 'arabic',
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        wordSpacing: 20,
        letterSpacing: 0.1,
        fontFamily: 'arabic',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        wordSpacing: 16,
        letterSpacing: 0.5,
        fontFamily: 'arabic',
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        wordSpacing: 16,
        letterSpacing: 0.5,
        fontFamily: 'arabic',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        wordSpacing: 24,
        letterSpacing: 0.15,
        fontFamily: 'arabic',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        wordSpacing: 20,
        letterSpacing: 0.25,
        fontFamily: 'arabic',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        wordSpacing: 16,
        letterSpacing: 0.4,
        fontFamily: 'arabic',
      ),
    ),
  );

  static ThemeData myLightMode = ThemeData.light().copyWith(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff02979D),
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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        wordSpacing: 64,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        wordSpacing: 52,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        wordSpacing: 44,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        wordSpacing: 40,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        wordSpacing: 36,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        wordSpacing: 32,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        wordSpacing: 28,
        letterSpacing: 0,
        fontFamily: 'arabic',
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        wordSpacing: 24,
        letterSpacing: 0.15,
        fontFamily: 'arabic',
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        wordSpacing: 20,
        letterSpacing: 0.1,
        fontFamily: 'arabic',
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        wordSpacing: 20,
        letterSpacing: 0.1,
        fontFamily: 'arabic',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        wordSpacing: 16,
        letterSpacing: 0.5,
        fontFamily: 'arabic',
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        wordSpacing: 16,
        letterSpacing: 0.5,
        fontFamily: 'arabic',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        wordSpacing: 24,
        letterSpacing: 0.15,
        fontFamily: 'arabic',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        wordSpacing: 20,
        letterSpacing: 0.25,
        fontFamily: 'arabic',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        wordSpacing: 16,
        letterSpacing: 0.4,
        fontFamily: 'arabic',
      ),
    ),
  );
}
