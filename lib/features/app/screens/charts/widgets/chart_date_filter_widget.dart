import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/enums/chart_date_option_enum.dart';
import 'package:enginner_project/features/app/screens/charts/controllers/charts_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartDateFilterForm extends StatelessWidget {
  const ChartDateFilterForm({super.key, required this.controller});

  final ChartsController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.chartFilterFormKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Data początkowa',
            controller: controller.startingDate,
            isReadOnly: true,
            suffixIcon: const Icon(Icons.calendar_month),
            function: () => controller.selectStartingDate(context),
          ),
          const SizedBox(width: 10),
          CustomTextField(
            hintText: 'Data końcowa',
            controller: controller.endingDate,
            isReadOnly: true,
            suffixIcon: const Icon(Icons.calendar_month),
            function: () => controller.selectEndingDate(context),
          ),
          Row(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: CustomButton(
                  text: 'Zamknij',
                  height: 40,
                  width: 12,
                  redirection: () {
                    Get.back();
                  },
                  colorGradient1: AppColors.redColorGradient,
                  colorGradient2: AppColors.blueButton,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  text: 'Zapisz',
                  height: 40,
                  width: 12,
                  redirection: () {
                    controller.selectedView.value = ChartDateOptionEnum.flag;
                    controller.selectedView.value = ChartDateOptionEnum.custom;
                  },
                  colorGradient1: AppColors.greenColorGradient,
                  colorGradient2: AppColors.blueButton,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Resetuj',
                  height: 40,
                  width: 12,
                  redirection: () => controller.resetFilters(),
                  colorGradient1: AppColors.loginBackgorund1,
                  colorGradient2: AppColors.blueButton,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
