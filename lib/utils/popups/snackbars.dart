import 'package:enginner_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbars {
  static succesSnackbar({required title, required message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor: AppColors.greenColorGradient.withOpacity(0.3),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.check,
        size: 30,
      ),
      colorText: AppColors.textPrimaryColor,
      padding: const EdgeInsets.all(20),
    );
  }

  static errorSnackbar({required title, required message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor: AppColors.redColorGradient.withOpacity(0.4),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.warning,
        size: 30,
      ),
      colorText: AppColors.textPrimaryColor,
      padding: const EdgeInsets.all(20),
    );
  }

  static warningSnackbar({required title, required message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor: Colors.amber.withOpacity(0.25),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.warning_amber,
        size: 30,
      ),
      colorText: AppColors.textPrimaryColor,
      padding: const EdgeInsets.all(20),
    );
  }

  static infoSnackbar({required title, required message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor: AppColors.blueButton.withOpacity(0.25),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.question_mark,
        size: 30,
      ),
      colorText: AppColors.textPrimaryColor,
      padding: const EdgeInsets.all(20),
    );
  }
}
