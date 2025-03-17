import 'package:enginner_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextAppTheme {
  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 57.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.2,
          letterSpacing: 0.5,
        ),
      ),
      displayMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.3,
          letterSpacing: 0.5,
        ),
      ),
      displaySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.4,
          letterSpacing: 0.4,
        ),
      ),
      headlineLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.4,
          letterSpacing: 0.4,
        ),
      ),
      headlineMedium: GoogleFonts.archivoBlack(
        textStyle: const TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.5,
          letterSpacing: 0.3,
        ),
      ),
      headlineSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.5,
          letterSpacing: 0.3,
        ),
      ),
      titleLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.5,
          letterSpacing: 0.3,
        ),
      ),
      titleMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          overflow: TextOverflow.ellipsis,
          height: 1.6,
          letterSpacing: 0.2,
        ),
      ),
      titleSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.6,
          letterSpacing: 0.2,
        ),
      ),
      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.fade,
          height: 1.7,
          letterSpacing: 0.2,
        ),
      ),
      bodyMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
          color: AppColors.textPrimaryColor,
          overflow: TextOverflow.fade,
          height: 1.7,
          letterSpacing: 0.1,
        ),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondaryColor,
          overflow: TextOverflow.ellipsis,
          height: 1.8,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
