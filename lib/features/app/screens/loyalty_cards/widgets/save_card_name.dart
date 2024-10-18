import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/app/screens/loyalty_cards/controllers/loyalty_cards_form_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveCardTitle extends StatelessWidget {
  const SaveCardTitle({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoyaltyCardsFormController());
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Podaj nazwe karty lojalnościowej',
              style: TextAppTheme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Form(
              key: controller.saveCardFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller.title,
                    validator: (value) =>
                        Validator.validateEmptyText('Nazwa', value),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'Zapisz',
                    height: 40,
                    width: 150,
                    redirection: () => controller.saveCard(code),
                    colorGradient1: AppColors.blueButton,
                    colorGradient2: AppColors.greenColorGradient,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
