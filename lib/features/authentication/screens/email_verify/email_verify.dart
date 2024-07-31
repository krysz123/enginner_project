import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/features/authentication/controllers/signup/email_verify_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerifyController());
    final height = DeviceUtility.getScreenHeight();
    final width = DeviceUtility.getScreenWidth(context);
    final appBarHeight = DeviceUtility.getAppBarHeight();

    return Stack(
      children: [
        Scaffold(
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.lg, vertical: Sizes.xxl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: height * 0.05),
                    Lottie.asset(
                      'assets/images/verify_email/verify_email.json',
                      height: height * 0.4,
                    ),
                    Text(
                      '$email',
                      style: TextAppTheme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Na podany adres e-mail został wysłany link potwierdzający. Kliknij w niego aby zweryfikować swój profil',
                      style: TextAppTheme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.15),
                    CustomButton(
                      text: 'Kontynuj',
                      height: height * 0.08,
                      width: width,
                      redirection: () =>
                          controller.checkEmailVerificationStatus(),
                      colorGradient1: AppColors.deleteExpenseColor,
                      colorGradient2: AppColors.blueButton,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: appBarHeight,
          right: 30,
          child: IconButton(
            icon: const Icon(
              Icons.clear,
              size: 30,
            ),
            onPressed: () => AuthenticationRepository.instance.logout(),
          ),
        ),
      ],
    );
  }
}
