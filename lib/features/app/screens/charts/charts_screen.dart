import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/enums/chart_date_option_enum.dart';
import 'package:enginner_project/features/app/controllers/charts_controller.dart';
import 'package:enginner_project/features/app/screens/charts/widgets/chart_list.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChartsController());
    final charts = ListCharts().chartList;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                children: charts,
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Tygodniowy',
                        height: 50,
                        width: 10,
                        redirection: () {
                          controller.selectedView.value =
                              ChartDateOptionEnum.week;
                        },
                        colorGradient1: controller.selectedView.value ==
                                ChartDateOptionEnum.week
                            ? AppColors.greenColorGradient
                            : AppColors.redColorGradient,
                        colorGradient2: AppColors.blueButton,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: 'Miesięczny',
                        height: 50,
                        width: 10,
                        redirection: () {
                          controller.selectedView.value =
                              ChartDateOptionEnum.month;
                        },
                        colorGradient1: controller.selectedView.value ==
                                ChartDateOptionEnum.month
                            ? AppColors.greenColorGradient
                            : AppColors.redColorGradient,
                        colorGradient2: AppColors.blueButton,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: 'Roczny',
                        height: 50,
                        width: 10,
                        redirection: () {
                          controller.selectedView.value =
                              ChartDateOptionEnum.year;
                        },
                        colorGradient1: controller.selectedView.value ==
                                ChartDateOptionEnum.year
                            ? AppColors.greenColorGradient
                            : AppColors.redColorGradient,
                        colorGradient2: AppColors.blueButton,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
