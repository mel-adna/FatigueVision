import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _gptDarkBg = Color(0xFF343541);
  static const _gptDarkSurface = Color(0xFF444654);
  static const _gptTeal = Color(0xFF10A37F);
  static const _gptLightBg = Color(0xFFFFFFFF);
  static const _gptLightSurface = Color(0xFFF7F7F8);

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: _gptLightBg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _gptTeal,
      primary: _gptTeal,
      surface: _gptLightSurface,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _gptLightBg,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    textTheme: GoogleFonts.interTextTheme(),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _gptDarkBg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _gptTeal,
      primary: _gptTeal,
      surface: _gptDarkSurface,
      background: _gptDarkBg, // Deprecated but often needed
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _gptDarkBg,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: const Color(0xFFECECF1),
      displayColor: const Color(0xFFECECF1),
    ),
  );
}
