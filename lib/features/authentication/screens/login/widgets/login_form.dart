import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/authentication/controllers/login/login_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final controller = Get.put(LoginController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.xxl),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'E-mail',
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
            ),
            Obx(
              () => CustomTextField(
                hintText: 'Hasło',
                controller: controller.password,
                validator: (value) =>
                    Validator.validateEmptyText('Hasło', value),
                isObscureText: controller.isShowPasswordEnableLogin.value,
                suffixIcon: GestureDetector(
                  onTap: () => controller.changeShowPasswordStatus(),
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
            SizedBox(height: height * 0.25),
            CustomButton(
              text: 'Zaloguj',
              height: 50,
              width: 200,
              redirection: () => controller.signIn(),
              colorGradient1: AppColors.redColorGradient,
              colorGradient2: AppColors.blueButton,
            ),
          ],
        ),
      ),
    );
  }
}
