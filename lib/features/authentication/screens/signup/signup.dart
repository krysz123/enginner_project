import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/authentication/controllers/signup/signup_controller.dart';
import 'package:enginner_project/features/authentication/screens/email_verify/email_verify.dart';
import 'package:enginner_project/features/authentication/screens/login/login.dart';
import 'package:enginner_project/common/widgets/account_link_text.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final width = DeviceUtility.getScreenWidth(context);
    final controller = Get.put(SignupController());

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rejestracja',
                    style: TextAppTheme.textTheme.displaySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.xxl),
                    child: Form(
                      child: Column(
                        children: [
                          const CustomTextField(hintText: 'Imie'),
                          const CustomTextField(hintText: 'Nazwisko'),
                          const CustomTextField(hintText: 'E-mail'),
                          Obx(
                            () => CustomTextField(
                              hintText: 'Hasło',
                              isObscureText:
                                  controller.isShowPasswordEnable.value,
                              suffixIcon: GestureDetector(
                                onTap: () =>
                                    controller.changeShowPasswordStatus(),
                                child: controller.isShowPasswordEnable.value
                                    ? const Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: AppColors.textSecondaryColor,
                                      )
                                    : const Icon(Icons.remove_red_eye_rounded,
                                        color: AppColors.textSecondaryColor),
                              ),
                            ),
                          ),
                          Obx(
                            () => CustomTextField(
                              hintText: 'Powtórz hasło',
                              isObscureText:
                                  controller.isShowRepeatPasswordEnable.value,
                              suffixIcon: GestureDetector(
                                onTap: () =>
                                    controller.changeShowRepeatPasswordStatus(),
                                child: controller
                                        .isShowRepeatPasswordEnable.value
                                    ? const Icon(Icons.remove_red_eye_outlined,
                                        color: AppColors.textSecondaryColor)
                                    : const Icon(Icons.remove_red_eye_rounded,
                                        color: AppColors.textSecondaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    text: 'Zarejestruj',
                    height: 50,
                    width: 200,
                    redirection: () => Get.offAll(
                      () => const EmailVerificationScreen(),
                    ),
                    colorGradient1: AppColors.redColorGradient,
                    colorGradient2: AppColors.blueButton,
                  ),
                  SizedBox(height: height * 0.05),
                  AccountLinkText(
                    text: 'Posiadasz konto?',
                    textLink: 'Zaloguj sie!',
                    redirection: () => Get.to(
                      () => const LoginScreen(),
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
