import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/features/app/controllers/expense_form_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeForm extends StatelessWidget {
  IncomeForm({
    super.key,
  });
  final categories = [
    const DropdownMenuItem(
        value: 'Wynagrodzenie', child: Text('Wynagrodzenie')),
    const DropdownMenuItem(value: 'Renta', child: Text('Renta')),
    const DropdownMenuItem(value: 'Podatki', child: Text('Podatki')),
    // const DropdownMenuItem(value: 'podatki', child: Text('Podatki')),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpenseFormController());

    return Form(
      key: controller.incomeFormKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Tytuł',
            controller: controller.title,
            validator: (value) => Validator.validateEmptyText('Tytuł', value),
          ),
          CustomTextField(
            hintText: 'Kwota',
            controller: controller.amount,
            keyboardType: TextInputType.number,
            validator: (value) => Validator.validateNumbersOnly(value),
          ),
          CustomTextField(
            hintText: 'Notatka',
            controller: controller.description,
            validator: (value) => Validator.validateEmptyText('Notatka', value),
          ),
          CustomTextField(
            hintText: 'Data',
            controller: controller.time,
            isReadOnly: true,
            validator: (value) => Validator.validateEmptyText('Data', value),
            suffixIcon: const Icon(Icons.calendar_month),
            function: () {
              controller.selectDate(context);
            },
          ),
          DropdownButtonFormField(
            value: controller.selectedCategory.value.isEmpty
                ? null
                : controller.selectedCategory.value,
            dropdownColor: AppColors.primary,
            hint: const Text('Kategoria'),
            items: categories,
            onChanged: (value) => controller.changeCategory(value),
            validator: (value) => Validator.validateDropdownSelection(value),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            value: controller.selectedPaymentType.value.isEmpty
                ? null
                : controller.selectedPaymentType.value,
            hint: const Text('Rodzaj płatności'),
            dropdownColor: AppColors.primary,
            validator: (value) => Validator.validateDropdownSelection(value),
            items: const [
              DropdownMenuItem(value: 'karta', child: Text('Karta kredytowa')),
              DropdownMenuItem(value: 'gotowka', child: Text('Gotówka')),
            ],
            onChanged: (value) => controller.changePaymentType(value),
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
                  redirection: () => controller.saveIncome(),
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
