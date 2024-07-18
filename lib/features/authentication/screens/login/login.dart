import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/authentication/controllers/login/login_controller.dart';
import 'package:enginner_project/features/authentication/controllers/signup/signup_controller.dart';
import 'package:enginner_project/features/authentication/screens/email_verify/email_verify.dart';
import 'package:enginner_project/features/authentication/screens/login/login.dart';
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
                    'Logowanie',
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
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CustomTextField(hintText: 'E-mail'),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => CustomTextField(
                            hintText: 'Hasło',
                            isObscureText:
                                controller.isShowPasswordEnableLogin.value,
                            suffixIcon: GestureDetector(
                              onTap: () =>
                                  controller.changeShowPasswordStatus(),
                              child: controller.isShowPasswordEnableLogin.value
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
                SizedBox(
                  height: height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text: 'Zaloguj',
                        height: 50,
                        width: 200,
                        redirection: () =>
                            Get.snackbar("Lgownaie", "Zaloguj sie"),
                        colorGradient1: AppColors.redColorGradient,
                        colorGradient2: AppColors.blueButton,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nie posiadasz konta?',
                            style: TextAppTheme.textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            child: Text(
                              "Zarejestruj sie!",
                              style:
                                  TextAppTheme.textTheme.bodyMedium!.copyWith(
                                color: AppColors.deleteExpenseColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => Get.to(() => const SignupScreen(),
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
