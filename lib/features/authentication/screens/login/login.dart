import 'package:enginner_project/common/widgets/account_link_text.dart';
import 'package:enginner_project/features/authentication/screens/login/widgets/login_form.dart';
import 'package:enginner_project/features/authentication/screens/signup/signup.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final width = DeviceUtility.getScreenWidth(context);

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.loginBackgorund1.withOpacity(0.4),
              AppColors.loginBackgorund1,
              AppColors.loginBackgorund2,
              AppColors.loginBackgorund3,
              AppColors.loginBackgorund4,
              AppColors.loginBackgorund5,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.lg, vertical: Sizes.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Logowanie',
                    style: TextAppTheme.textTheme.displaySmall,
                  ),
                  const LoginForm(),
                  AccountLinkText(
                    text: 'Nie posiadasz konta?',
                    textLink: 'Zarejestruj sie!',
                    redirection: () => Get.offAll(
                      () => const SignupScreen(),
                      transition: Transition.fadeIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
