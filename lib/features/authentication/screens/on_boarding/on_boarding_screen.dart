import 'package:enginner_project/features/authentication/controllers/onboarding/on_boarding_controller.dart';
import 'package:enginner_project/features/authentication/screens/on_boarding/widgets/on_boarding_page_widget.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final appBarHeight = DeviceUtility.getAppBarHeight();
    final controller = Get.put(OnBoardingController());

    final pages = [
      OnBoardingPage(
        lastPage: false,
        height: height,
        color: AppColors.primary,
        image: 'assets/images/onboarding/onBoarding1.gif',
        title: 'Kontrola wydatków w zasięgu ręki!',
        subTitle:
            'Zapisuj wydatki, analizuj je za pomocą wykresów i rozliczaj się ze znajomymi – wszystko w jednej aplikacji!',
      ),
      OnBoardingPage(
        lastPage: false,
        height: height,
        color: AppColors.onBoarding2,
        image: 'assets/images/onboarding/onBoarding2.gif',
        title: 'Poznaj swoje nawyki zakupowe',
        subTitle:
            'Odkryj, na co wydajesz najwięcej, zyskaj kontrolę nad budżetem i oszczędzaj więcej dzięki przejrzystym analizom Twoich wydatków.',
      ),
      OnBoardingPage(
        lastPage: true,
        height: height,
        color: AppColors.onBoarding3,
        image: 'assets/images/onboarding/onBoarding3.gif',
        title: 'Łatwe rozliczanie ze znajomymi',
        subTitle:
            'Zapomnij o niewygodnych rozliczeniach! Szybko i bezproblemowo rozliczaj wspólne wydatki, unikając kłopotów i niedomówień.',
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            liquidController: controller.liquidController,
            onPageChangeCallback: controller.updatePage,
            enableLoop: false,
            waveType: WaveType.circularReveal,
            slideIconWidget: Obx(
              () => controller.currentPage.value == 2
                  ? const Icon(null)
                  : const Icon(Icons.arrow_back),
            ),
            positionSlideIcon: 0.85,
            fullTransitionValue: 600,
            enableSideReveal: false,
            pages: pages,
          ),
          Positioned(
            top: appBarHeight,
            right: 30,
            child: TextButton(
              onPressed: () => controller.skipPage(),
              child: Text(
                'Pomiń',
                style: TextAppTheme.textTheme.titleSmall,
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 30,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage.value,
                count: 3,
                effect: const WormEffect(
                  activeDotColor: AppColors.greenColorGradient,
                  dotHeight: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
