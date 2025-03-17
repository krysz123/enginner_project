import 'package:enginner_project/common/widgets/buttons/button.dart';

import 'package:enginner_project/features/authentication/screens/signup/signup.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.height,
    required this.color,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.lastPage,
  });

  final double height;
  final Color color;
  final String image;
  final String title;
  final String subTitle;
  final bool lastPage;

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Sizes.xl, vertical: Sizes.xxl),
      color: color,
      child: Column(
        children: [
          Image(image: AssetImage(image), height: height * 0.4),
          Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextAppTheme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  subTitle,
                  style: TextAppTheme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                if (lastPage) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.xxl),
                    child: CustomButton(
                      colorGradient1: AppColors.greenColorGradient,
                      colorGradient2: AppColors.blueButton,
                      text: 'Dalej',
                      height: 50,
                      width: 160,
                      redirection: () async {
                        // final shpref = await SharedPreferences.getInstance();
                        // shpref.setBool("onboarding", true);

                        Get.offAll(
                          () => const SignupScreen(),
                          transition: Transition.leftToRight,
                        );
                      },
                    ),
                  )
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
