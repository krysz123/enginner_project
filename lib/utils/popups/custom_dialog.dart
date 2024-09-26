import 'dart:ui';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  final height = DeviceUtility.getScreenHeight();

  static customDialog({
    required String title,
    required String subtitle,
    required Widget widget,
    required IconData icon,
  }) {
    Get.dialog(
      Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                  child: Material(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Dodane wyrównanie w pionie
                            children: [
                              Icon(
                                icon,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextAppTheme.textTheme.titleLarge,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                    Text(
                                      subtitle,
                                      style: TextAppTheme.textTheme.labelMedium,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            child: widget,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
