import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/app/screens/saving_goals/controllers/add_saving_amount_form_controller.dart';
import 'package:enginner_project/models/saving_goal_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSavingAmountForm extends StatelessWidget {
  const AddSavingAmountForm({super.key, required this.savingGoal});

  final SavingGoalModel savingGoal;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddSavingAmountFormController());

    double calculateAmountToFinish() {
      double amountToFinish = savingGoal.goal - savingGoal.currentAmount;

      if (amountToFinish < 0) {
        return 0;
      } else {
        return double.parse(amountToFinish.toStringAsFixed(2));
      }
    }

    return Form(
        key: controller.savingAmountFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: controller.amount,
              hintText: 'Kwota',
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validateNumbersOnly(value),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Pozostało: ${calculateAmountToFinish()} PLN',
                style: TextAppTheme.textTheme.titleSmall,
              ),
            ),
            Row(
              children: [
                const SizedBox(height: 50),
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
                    redirection: () =>
                        controller.updateSavingGoalProgress(savingGoal),
                    colorGradient1: AppColors.greenColorGradient,
                    colorGradient2: AppColors.blueButton,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
