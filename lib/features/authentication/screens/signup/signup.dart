import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/authentication/controllers/signup/signup_controller.dart';
import 'package:enginner_project/features/authentication/screens/email_verify/email_verify.dart';
import 'package:enginner_project/features/authentication/screens/login/login.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final width = DeviceUtility.getScreenWidth(context);
    final controller = Get.put(SignupController());

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.lg, vertical: Sizes.sm),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Center(
                  child: Text(
                    'Rejestracja',
                    style: TextAppTheme.textTheme.displaySmall,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: height * 0.45,
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              child: controller.isShowRepeatPasswordEnable.value
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
                SizedBox(
                  height: height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Posiadasz konto?',
                            style: TextAppTheme.textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            child: Text(
                              "Zaloguj sie!",
                              style:
                                  TextAppTheme.textTheme.bodyMedium!.copyWith(
                                color: AppColors.deleteExpenseColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => Get.to(() => const LoginScreen(),
                                transition: Transition.fadeIn),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
