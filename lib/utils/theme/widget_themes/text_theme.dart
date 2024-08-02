// import 'package:enginner_project/utils/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TextAppTheme {
//   TextAppTheme._();
//   static TextTheme textTheme = TextTheme(
//     labelLarge: GoogleFonts.poppins(
//       color: AppColors.textPrimaryColor,
//     ),

//     // BIG LABELS

//     headlineLarge: const TextStyle().copyWith(
//         fontSize: 35.0,
//         fontWeight: FontWeight.bold,
//         color: AppColors.textPrimaryColor),
//     headlineMedium: const TextStyle().copyWith(
//         fontSize: 25.0,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimaryColor),
//     headlineSmall: const TextStyle().copyWith(
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//         color: AppColors.textPrimaryColor),

//     // SMALL LABELS

//     titleLarge: const TextStyle().copyWith(
//         fontSize: 15.0,
//         fontWeight: FontWeight.bold,
//         color: AppColors.textPrimaryColor),
//     titleMedium: const TextStyle().copyWith(
//         fontSize: 15.0,
//         fontWeight: FontWeight.w500,
//         color: AppColors.textPrimaryColor),
//     titleSmall: const TextStyle().copyWith(
//         fontSize: 13.0,
//         fontWeight: FontWeight.w400,
//         color: AppColors.textPrimaryColor),

//     // SMALL SUBTITLES

//     bodyLarge: const TextStyle().copyWith(
//         fontSize: 13.0,
//         fontWeight: FontWeight.w400,
//         color: AppColors.textSecondaryColor),
//     bodyMedium: const TextStyle().copyWith(
//         fontSize: 15.0,
//         fontWeight: FontWeight.w400,
//         color: AppColors.textSecondaryColor),
//   );
// }

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
        ),
      ),
      displayMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
      ),
      displaySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
      ),
      headlineLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
      ),
      headlineMedium: GoogleFonts.archivoBlack(
        textStyle: const TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
      ),
      headlineSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
      ),
      titleLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
      ),
      titleMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      titleSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
      ),
      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimaryColor,
        ),
      ),
      bodyMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
          color: AppColors.textPrimaryColor,
        ),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondaryColor,
        ),
      ),
    );
  }
}
