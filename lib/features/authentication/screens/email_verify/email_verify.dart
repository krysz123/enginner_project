import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/features/authentication/screens/login/login.dart';
import 'package:enginner_project/features/authentication/screens/signup/signup.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final width = DeviceUtility.getScreenWidth(context);

    return Scaffold(
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.lg, vertical: Sizes.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage(
                    'assets/images/email_verify/email_verify.gif'),
                height: height * 0.5,
              ),
              Text(
                'Zweryfikuj adres email',
                style: TextAppTheme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                'Na podany adres e-mail został wysłany link potwierdzający. Kliknij w niego aby zweryfikować swój profil',
                style: TextAppTheme.textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.lg),
                child: CustomButton(
                    text: 'Kontynuj',
                    height: height * 0.08,
                    width: width,
                    redirection: () => Get.offAll(() => const LoginScreen()),
                    colorGradient1: AppColors.greenColorGradient,
                    colorGradient2: AppColors.blueButton),
              )
            ],
          ),
        ),
      ),
    );
  }
}
