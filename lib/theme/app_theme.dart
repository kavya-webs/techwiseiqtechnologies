// TechWiseIQ — Application Theme Definition
//
// Defines the dark theme used throughout the app. Typography uses two font
// families from Google Fonts:
// - Cormorant Garamond — for display/headline text (elegant, serif)
// - Inter — for body, labels, and UI text (clean, sans-serif)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Central theme configuration for the TechWiseIQ app.
/// Access via [AppTheme.darkTheme] in MaterialApp.
class AppTheme {
  /// Returns the application's dark [ThemeData] with custom typography
  /// and brand colors applied globally.
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 72,
          fontWeight: FontWeight.w500,
          height: 1.1,
          color: AppColors.white,
        ),
        displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 64,
          fontWeight: FontWeight.w500,
          height: 1.15,
          color: AppColors.white,
        ),
        displaySmall: GoogleFonts.cormorantGaramond(
          fontSize: 48,
          fontWeight: FontWeight.w500,
          height: 1.2,
          color: AppColors.white,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.cyan,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          height: 1.7,
          color: AppColors.grey,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          height: 1.6,
          color: AppColors.grey,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 3,
          color: AppColors.cyan,
        ),
      ),
    );
  }
}
