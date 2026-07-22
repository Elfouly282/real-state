import 'package:flutter/material.dart';

class FontWeightManager {
  static const FontWeight thin      = FontWeight.w200;
  static const FontWeight light     = FontWeight.w300;
  static const FontWeight regular   = FontWeight.w400;
  static const FontWeight medium    = FontWeight.w500;
  static const FontWeight semiBold  = FontWeight.w600;
  static const FontWeight bold      = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}

class AppFonts {
  // Font family name for Poppins (loaded via google_fonts).
  // Using the literal string avoids a runtime call to GoogleFonts.poppins()
  // which cannot be const and causes "Invalid constant value" warnings.
  static const String questFont = 'Poppins';

  // Font sizes
  static const double displayLarge = 57;
  static const double displayMedium = 45;
  static const double displaySmall = 36;
  static const double headlineLarge = 32;
  static const double headlineMedium = 28;
  static const double headlineSmall = 24;
  static const double titleLarge = 22;
  static const double titleMedium = 16;
  static const double titleSmall = 14;
  static const double bodyLarge = 16;
  static const double bodyMedium = 14;
  static const double bodySmall = 12;
  static const double labelLarge = 14;
  static const double labelMedium = 12;
  static const double labelSmall = 11;
  static const double inputText = 14;
  static const double buttonTextSize = 16;
}
