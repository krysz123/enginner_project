import 'package:enginner_project/common/widgets/account_link_text.dart';
import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/authentication/controllers/login/login_controller.dart';
import 'package:enginner_project/features/authentication/screens/signup/signup.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final width = DeviceUtility.getScreenWidth(context);
    final controller = Get.put(LoginController());

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
                    'Logowanie',
                    style: TextAppTheme.textTheme.displaySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.xxl),
                    child: Form(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomTextField(hintText: 'E-mail'),
                          Obx(
                            () => CustomTextField(
                              hintText: 'Hasło',
                              isObscureText:
                                  controller.isShowPasswordEnableLogin.value,
                              suffixIcon: GestureDetector(
                                onTap: () =>
                                    controller.changeShowPasswordStatus(),
                                child: controller
                                        .isShowPasswordEnableLogin.value
                                    ? const Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: AppColors.textSecondaryColor,
                                      )
                                    : const Icon(Icons.remove_red_eye_rounded,
                                        color: AppColors.textSecondaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.25),
                  CustomButton(
                    text: 'Zaloguj',
                    height: 50,
                    width: 200,
                    redirection: () => Get.snackbar(
                      "Lgownaie",
                      "Zaloguj sie",
                      animationDuration: const Duration(milliseconds: 500),
                      icon: const Icon(
                        Icons.abc_outlined,
                        size: 30,
                      ),
                    ),
                    colorGradient1: AppColors.redColorGradient,
                    colorGradient2: AppColors.blueButton,
                  ),
                  SizedBox(height: height * 0.05),
                  AccountLinkText(
                    text: 'Nie posiadasz konta?',
                    textLink: 'Zarejestruj sie!',
                    redirection: () => Get.to(
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
