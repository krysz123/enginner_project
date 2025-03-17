import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/models/shared_account_expense_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SharedAccountTransactionDetails extends StatelessWidget {
  const SharedAccountTransactionDetails(
      {super.key, required this.sharedAccountTransaction});

  final SharedAccountExpenseModel sharedAccountTransaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Kwota: ', style: TextAppTheme.textTheme.titleMedium),
            Text('${sharedAccountTransaction.amount.toString()} PLN',
                style: TextAppTheme.textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Wysyłający: ', style: TextAppTheme.textTheme.titleMedium),
            Text(sharedAccountTransaction.sender.toString(),
                style: TextAppTheme.textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Data: ', style: TextAppTheme.textTheme.titleMedium),
            Text(sharedAccountTransaction.date.toString(),
                style: TextAppTheme.textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Kategoria: ', style: TextAppTheme.textTheme.titleMedium),
            Text(sharedAccountTransaction.category.toString(),
                style: TextAppTheme.textTheme.bodyLarge)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Typ: ', style: TextAppTheme.textTheme.titleMedium),
            Text(
              sharedAccountTransaction.expenseType.toString(),
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
              sharedAccountTransaction.paymentType.toString(),
              style: TextAppTheme.textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(height: 30),
        Center(
          child: CustomButton(
            text: 'Zamknij',
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
