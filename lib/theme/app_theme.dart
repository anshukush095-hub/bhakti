import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand & Primary
  static const Color primaryMaroon = Color(0xFF8C2224);
  static const Color primaryCrimson = Color(0xFFA82B2B);
  static const Color primarySaffron = Color(0xFFE58B12);
  static const Color primaryTeal = Color(0xFF0C7674);
  static const Color lightTeal = Color(0xFFE4F3F2);
  static const Color accentGold = Color(0xFFFFD700);

  // Backgrounds & Surfaces
  static const Color bgCream = Color(0xFFFBF8F3);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgCardWarm = Color(0xFFFFFBF6);
  static const Color borderSubtle = Color(0xFFEFE8DD);
  static const Color borderWarm = Color(0xFFF3E3D0);

  // Text Colors
  static const Color textDark = Color(0xFF231B15);
  static const Color textMedium = Color(0xFF6B5F54);
  static const Color textMuted = Color(0xFF988C80);

  // Status & Chaughadiya Colors
  static const Color chaughadiyaShubhBg = Color(0xFFD8F3DC);
  static const Color chaughadiyaShubhText = Color(0xFF1B6C28);

  static const Color chaughadiyaRogBg = Color(0xFFFCE1D6);
  static const Color chaughadiyaRogText = Color(0xFFA04000);

  static const Color chaughadiyaUdvegBg = Color(0xFFFCE4EC);
  static const Color chaughadiyaUdvegText = Color(0xFF880E4F);

  static const Color chaughadiyaCharBg = Color(0xFFD6EAF8);
  static const Color chaughadiyaCharText = Color(0xFF2874A6);

  // Dark Theme specifics
  static const Color bgDark = Color(0xFF191412);
  static const Color bgDarkCard = Color(0xFF261F1B);
  static const Color borderDark = Color(0xFF382F2A);
  static const Color textDarkPrimary = Color(0xFFF8F4EE);
  static const Color textDarkSecondary = Color(0xFFB5A99D);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bgCream,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryMaroon,
        secondary: AppColors.primaryTeal,
        surface: AppColors.bgCard,
        surfaceContainerHighest: AppColors.bgCardWarm,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textDark,
      ),
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(
        ThemeData.light().textTheme,
      ).apply(
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgCream,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primarySaffron,
        secondary: AppColors.primaryTeal,
        surface: AppColors.bgDarkCard,
        surfaceContainerHighest: AppColors.bgDarkCard,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: AppColors.textDarkPrimary,
      ),
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.textDarkPrimary,
        displayColor: AppColors.textDarkPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgDark,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDarkPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textDarkPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.bgDarkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),
    );
  }
}
