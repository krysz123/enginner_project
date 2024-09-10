import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ExpenseDetails extends StatelessWidget {
  const ExpenseDetails({super.key, required this.transaction});

  final ExpenseModel transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Kwota: ', style: TextAppTheme.textTheme.titleMedium),
            Text('${transaction.amount.toString()} zł',
                style: TextAppTheme.textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Data: ', style: TextAppTheme.textTheme.titleMedium),
            Text(transaction.date.toString(),
                style: TextAppTheme.textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Kategoria: ', style: TextAppTheme.textTheme.titleMedium),
            Text(transaction.category.toString(),
                style: TextAppTheme.textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Typ: ', style: TextAppTheme.textTheme.titleMedium),
            Text(
              transaction.expenseType.toString(),
              style: TextAppTheme.textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Rodzaj płatności: ',
                style: TextAppTheme.textTheme.titleMedium),
            Text(
              transaction.paymentType.toString(),
              style: TextAppTheme.textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(height: 30),
        Center(
          child: CustomButton(
            text: 'Cofnij',
            height: 40,
            width: 150,
            redirection: (() => Get.back()),
            colorGradient1: AppColors.redColorGradient,
            colorGradient2: AppColors.blueButton,
          ),
        ),
      ],
    );
  }
}
