import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/enums/chart_date_option_enum.dart';
import 'package:enginner_project/features/app/screens/charts/controllers/charts_controller.dart';
import 'package:enginner_project/features/app/screens/charts/widgets/chart_date_filter_widget.dart';
import 'package:enginner_project/features/app/screens/charts/widgets/chart_list.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChartsController());
    final charts = ListCharts().chartList;
    controller.currentPage.value = 0;
    return Stack(
      children: [
        Obx(
          () {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: controller.currentPage < 2
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 56, right: 30),
                        child: IconButton(
                          onPressed: () => CustomDialog.customDialog(
                              title: 'Wybierz przedział czasowy',
                              subtitle:
                                  'Ustal w jakim okresie czasu chcesz sprawdzić swoje transakcje',
                              widget: ChartDateFilterForm(
                                controller: controller,
                              ),
                              icon: Icons.person),
                          icon: const Icon(
                            FontAwesomeIcons.filterCircleDollar,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            );
          },
        ),
        SafeArea(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: controller.currentPage < 2
                            ? FadeTransition(
                                opacity:
                                    const AlwaysStoppedAnimation<double>(1.0),
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
                                        colorGradient1:
                                            controller.selectedView.value ==
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
                                        colorGradient1:
                                            controller.selectedView.value ==
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
                                        colorGradient1:
                                            controller.selectedView.value ==
                                                    ChartDateOptionEnum.year
                                                ? AppColors.greenColorGradient
                                                : AppColors.redColorGradient,
                                        colorGradient2: AppColors.blueButton,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: AnimatedSmoothIndicator(
                          activeIndex: controller.currentPage.value,
                          count: charts.length,
                          effect: const WormEffect(
                            activeDotColor: AppColors.greenColorGradient,
                            dotHeight: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
