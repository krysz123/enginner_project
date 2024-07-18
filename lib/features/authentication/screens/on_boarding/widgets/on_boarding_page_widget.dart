import 'package:enginner_project/common/widgets/buttons/button.dart';

import 'package:enginner_project/features/authentication/screens/signup/signup.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(image), height: height * 0.4),
          Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextAppTheme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  subTitle,
                  style: TextAppTheme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (lastPage) ...[
            CustomButton(
              colorGradient1: AppColors.greenColorGradient,
              colorGradient2: AppColors.blueButton,
              text: 'Dalej',
              height: 50,
              width: 160,
              redirection: () async {
                final shpref = await SharedPreferences.getInstance();
                shpref.setBool("onboarding", true);

                Get.offAll(
                  () => const SignupScreen(),
                  transition: Transition.leftToRight,
                );
              },
            )
          ],
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
