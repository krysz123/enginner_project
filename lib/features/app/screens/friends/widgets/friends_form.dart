import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/app/screens/friends/controllers/add_friend_form_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsForm extends StatelessWidget {
  const FriendsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddFriendFormController());

    return Form(
      key: controller.addFriendFormKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'E-mail',
            controller: controller.email,
            validator: (value) => Validator.validateEmail(value),
          ),
          Row(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: CustomButton(
                  text: 'Zamknij',
                  height: 40,
                  width: 12,
                  redirection: (() => Get.back()),
                  colorGradient1: AppColors.redColorGradient,
                  colorGradient2: AppColors.blueButton,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  text: 'Zapisz',
                  height: 40,
                  width: 12,
                  redirection: () => controller.addFriend(),
                  colorGradient1: AppColors.greenColorGradient,
                  colorGradient2: AppColors.blueButton,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
