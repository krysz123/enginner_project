import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/enums/expense_category_enum.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/enums/income_category_enum.dart';
import 'package:enginner_project/enums/payment_type_enum.dart';
import 'package:enginner_project/features/app/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/controllers/shared_account_main_screen_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SharedAccountTransactionFilterForm extends StatelessWidget {
  const SharedAccountTransactionFilterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedAccountMainScreenController(''));
    return Obx(
      () => Form(
        key: controller.filterFormKey,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Tytuł',
              controller: controller.title,
            ),
            CustomTextField(
              hintText: 'Kwota minimalna',
              controller: controller.minAmount,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  Validator.validateOptionalNumbersOnly(value),
            ),
            CustomTextField(
              hintText: 'Kwota maksymalna',
              controller: controller.maxAmount,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  Validator.validateOptionalNumbersOnly(value),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Data początkowa',
                    controller: controller.startingDate,
                    isReadOnly: true,
                    suffixIcon: const Icon(Icons.calendar_month),
                    function: () => controller.selectStartingDate(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Data końcowa',
                    controller: controller.endingDate,
                    isReadOnly: true,
                    suffixIcon: const Icon(Icons.calendar_month),
                    function: () => controller.selectEndingDate(context),
                  ),
                ),
              ],
            ),
            DropdownButtonFormField(
              value: controller.selectedExpenseType.value.isEmpty
                  ? null
                  : controller.selectedExpenseType.value,
              hint: const Text('Typ'),
              dropdownColor: AppColors.primary,
              onChanged: (value) => controller.changeExpenseType(value),
              items: ExpenseTypeEnum.values
                  .map((e) => DropdownMenuItem(
                        value: e.label,
                        child: Row(
                          children: [
                            Icon(ExpenseTypeEnum.returnIcon(e.label)),
                            const SizedBox(width: 10),
                            Text(
                              e.label,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: controller.selectedPaymentType.value.isEmpty
                  ? null
                  : controller.selectedPaymentType.value,
              hint: const Text('Rodzaj płatności'),
              dropdownColor: AppColors.primary,
              onChanged: (value) => controller.changePaymentType(value),
              items: PaymentTypeEnum.values
                  .map((e) => DropdownMenuItem(
                        value: e.label,
                        child: Row(
                          children: [
                            Icon(PaymentTypeEnum.returnIcon(e.label)),
                            const SizedBox(width: 10),
                            Text(
                              e.label,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: controller.selectedExpenseCategory.value.isEmpty
                  ? null
                  : controller.selectedExpenseCategory.value,
              dropdownColor: AppColors.primary,
              onChanged: (value) => controller.changeExpenseCategory(value),
              hint: const Text('Kategoria wydatku'),
              isDense: true,
              items: ExpenseCategory.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.label,
                      child: Row(
                        children: [
                          Icon(ExpenseCategory.returnIcon(e.label)),
                          const SizedBox(width: 10),
                          Text(
                            e.label,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              isExpanded: false,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: controller.selectedIncomeCategroy.value.isEmpty
                  ? null
                  : controller.selectedIncomeCategroy.value,
              dropdownColor: AppColors.primary,
              hint: const Text('Kategoria przychodu'),
              isDense: true,
              items: IncomeCategory.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.label,
                      child: Row(
                        children: [
                          Icon(IncomeCategory.returnIcon(e.label)),
                          const SizedBox(width: 10),
                          Text(
                            e.label,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) => controller.changeIncomeCategory(value),
              isExpanded: false,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: controller.selectedUserName.value.isEmpty
                  ? null
                  : controller.selectedUserName.value,
              hint: const Text(
                "Wybierz użytkownika",
                overflow: TextOverflow.ellipsis,
              ),
              isExpanded: true,
              dropdownColor: AppColors.primary,
              items: controller.users.map((user) {
                String displayName = '${user['firstName']} ${user['lastName']}';
                return DropdownMenuItem(
                  value: displayName,
                  child: Text(
                    displayName,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) => controller.changeUser(value),
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
                const SizedBox(width: 10),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: 'Zapisz',
                    height: 40,
                    width: 12,
                    redirection: () =>
                        controller.filterTransactions(controller.title.text),
                    colorGradient1: AppColors.greenColorGradient,
                    colorGradient2: AppColors.blueButton,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Resetuj',
                    height: 40,
                    width: 12,
                    redirection: (() => controller.resetFilters()),
                    colorGradient1: AppColors.loginBackgorund1,
                    colorGradient2: AppColors.blueButton,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
