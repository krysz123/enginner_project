import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/enums/chart_date_option_enum.dart';
import 'package:enginner_project/features/app/screens/charts/controllers/charts_controller.dart';
import 'package:enginner_project/features/app/screens/charts/widgets/chart_list.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChartsController());
    final charts = ListCharts().chartList;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageViewController,
              onPageChanged: (index) => controller.updatePage(index),
              children: charts,
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: AnimatedSmoothIndicator(
                      activeIndex: controller.currentPage.value,
                      count: charts.length,
                      effect: const WormEffect(
                        activeDotColor: AppColors.greenColorGradient,
                        dotHeight: 5,
                      ),
                    ),
                  ),
                  Row(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
