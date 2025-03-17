import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/authentication/controllers/signup/signup_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Imie',
              controller: controller.firstName,
              validator: (value) => Validator.validateEmptyText('Imie', value),
            ),
            CustomTextField(
              hintText: 'Nazwisko',
              controller: controller.lastName,
              validator: (value) =>
                  Validator.validateEmptyText('Nazwisko', value),
            ),
            CustomTextField(
              hintText: 'E-mail',
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
            ),
            CustomTextField(
              hintText: 'Numer telefonu',
              controller: controller.phoneNumber,
              validator: (value) => Validator.validatePhoneNumber(value),
            ),
            Obx(
              () => CustomTextField(
                hintText: 'Hasło',
                controller: controller.password,
                isObscureText: controller.isShowPasswordEnable.value,
                validator: (value) => Validator.validatePassword(value),
                suffixIcon: GestureDetector(
                  onTap: () => controller.changeShowPasswordStatus(),
                  child: controller.isShowPasswordEnable.value
                      ? const Icon(
                          Icons.remove_red_eye_outlined,
                          color: AppColors.textSecondaryColor,
                        )
                      : const Icon(
                          Icons.remove_red_eye_rounded,
                          color: AppColors.textSecondaryColor,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Zarejestruj',
              height: 50,
              width: 200,
              redirection: () => controller.signup(),
              colorGradient1: AppColors.redColorGradient,
              colorGradient2: AppColors.blueButton,
            ),
          ],
        ),
      ),
    );
  }
}
