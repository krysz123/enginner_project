import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/expense_form.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomDialog {
  final height = DeviceUtility.getScreenHeight();

  static customDialog({required title, required subtitle, required widget}) {
    Get.dialog(SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Material(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextAppTheme.textTheme.titleLarge,
                        ),
                        Text(
                          subtitle,
                          style: TextAppTheme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
                widget,
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
