import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _gptDarkBg = Color(0xFF343541);
  static const _gptDarkSurface = Color(0xFF444654);
  static const _gptTeal = Color(0xFF10A37F);
  static const _gptLightBg = Color(0xFFF5F5F7);
  static const _gptLightSurface = Color(0xFFFFFFFF);

  static ThemeData light(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _gptLightBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _gptTeal,
        primary: _gptTeal,
        surface: _gptLightSurface,
        // brightness: Brightness.light, // Redundant, matches seed default effectively or set by ThemeData
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _gptLightBg,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      textTheme: isArabic
          ? GoogleFonts.cairoTextTheme()
          : GoogleFonts.interTextTheme(),
    );
  }

  static ThemeData dark(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _gptDarkBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _gptTeal,
        primary: _gptTeal,
        surface: _gptDarkSurface,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _gptDarkBg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme:
          (isArabic
                  ? GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme)
                  : GoogleFonts.interTextTheme(ThemeData.dark().textTheme))
              .apply(
                bodyColor: const Color(0xFFECECF1),
                displayColor: const Color(0xFFECECF1),
              ),
    );
  }
}
