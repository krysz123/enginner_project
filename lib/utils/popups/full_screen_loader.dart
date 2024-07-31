import 'package:enginner_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
        child: const SpinKitPouringHourGlass(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
