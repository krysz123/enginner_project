import 'package:enginner_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TextAppTheme {
  TextAppTheme._();
  static TextTheme textTheme = TextTheme(
    // BIG LABELS

    headlineLarge: const TextStyle().copyWith(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryColor),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryColor),

    // SMALL LABELS

    titleLarge: const TextStyle().copyWith(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryColor),
    titleMedium: const TextStyle().copyWith(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimaryColor),
    titleSmall: const TextStyle().copyWith(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryColor),

    // SMALL SUBTITLES

    bodyLarge: const TextStyle().copyWith(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryColor),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryColor),
  );
}
