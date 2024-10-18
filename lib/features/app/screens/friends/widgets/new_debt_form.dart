import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/app/screens/friends/controllers/new_debt_form_controller.dart';
import 'package:enginner_project/features/app/screens/saving_goals/controllers/saving_goal_controller.dart';
import 'package:enginner_project/models/friend_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewDebtForm extends StatelessWidget {
  const NewDebtForm({super.key, required this.friendId});

  final String friendId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewDebtFormController());
    return Form(
      key: controller.newDebtFormKey,
      child: Column(
        children: [
          CustomTextField(
            controller: controller.title,
            hintText: 'Tytuł',
            validator: (value) => Validator.validateEmptyText('Tytuł', value),
          ),
          CustomTextField(
            controller: controller.description,
            hintText: 'Opis',
            validator: (value) => Validator.validateEmptyText('Opis', value),
          ),
          CustomTextField(
            controller: controller.amount,
            hintText: 'Kwota',
            validator: (value) => Validator.validateNumbersOnly(value),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: CustomButton(
                  text: 'Cofnij',
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
                  redirection: () => controller.saveNewDebt(friendId),
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
