import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/enums/income_category_enum.dart';
import 'package:enginner_project/enums/payment_type_enum.dart';
import 'package:enginner_project/features/app/screens/main_screen/controllers/expense_form_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class IncomeForm extends StatelessWidget {
  const IncomeForm({
    super.key,
  });

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  'Przychód stały',
                  style: TextAppTheme.textTheme.titleMedium!
                      .copyWith(color: AppColors.textSecondaryColor),
                ),
                const Spacer(),
                Obx(
                  () => Checkbox(
                    value: controller.isChecked.value,
                    onChanged: (value) => controller.changeCheckbox(value),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.textSecondaryColor),
          const SizedBox(height: 10),
          DropdownButtonFormField(
            value: controller.selectedCategory.value.isEmpty
                ? null
                : controller.selectedCategory.value,
            dropdownColor: AppColors.primary,
            hint: const Text('Kategoria'),
            items: IncomeCategory.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e.label,
                    child: Text(
                      e.label,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => controller.changeCategory(value),
            validator: (value) => Validator.validateDropdownSelection(value),
            isExpanded: false,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            value: controller.selectedPaymentType.value.isEmpty
                ? null
                : controller.selectedPaymentType.value,
            hint: const Text('Rodzaj płatności'),
            dropdownColor: AppColors.primary,
            validator: (value) => Validator.validateDropdownSelection(value),
            items: PaymentTypeEnum.values
                .map((e) => DropdownMenuItem(
                      value: e.label,
                      child: Text(e.label),
                    ))
                .toList(),
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
              Expanded(
                child: CustomButton(
                  text: 'usun wszystok',
                  height: 40,
                  width: 12,
                  redirection: (() => Workmanager().cancelAll()),
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
