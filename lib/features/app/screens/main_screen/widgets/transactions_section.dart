import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/expense_category_enum.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/enums/income_category_enum.dart';
import 'package:enginner_project/enums/payment_type_enum.dart';
import 'package:enginner_project/features/app/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/expense_details.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/filter_form.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({
    super.key,
    required this.controller,
  });

  final MainScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: const BoxDecoration(
          color: AppColors.secondary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Moje transakcje',
                  style: TextAppTheme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () => CustomDialog.customDialog(
                    title: 'Filtruj transakcje',
                    subtitle: 'Wybierz dane do filtracji',
                    widget: const ExpenseFilterForm(),
                    icon: FontAwesomeIcons.filter,
                  ),
                  child: const Text('Filtr'),
                ),
              ],
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.filteredExpenses[index];

                    return GestureDetector(
                      onLongPress: () => CustomDialog.customDialog(
                        icon: Icons.monetization_on_outlined,
                        title: transaction.title,
                        subtitle: transaction.description,
                        widget: ExpenseDetails(transaction: transaction),
                      ),
                      child: Dismissible(
                        key: Key(transaction.id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) async {
                          await UserRepository.instance.deleteExpense(
                            transaction.expenseType,
                            transaction.id,
                            transaction.amount,
                          );

                          Snackbars.infoSnackbar(
                              title: 'Usunięto!',
                              message:
                                  'Transakcja ${transaction.title} została usunięta!');
                        },
                        background: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:
                                AppColors.deleteExpenseColor.withOpacity(0.5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(
                              Icons.delete_outline_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                        child: Card(
                          shape: transaction.expenseType ==
                                  ExpenseTypeEnum.periodicExpense.label
                              ? RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: AppColors.deleteExpenseColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                )
                              : transaction.expenseType ==
                                      ExpenseTypeEnum.periodicIncome.label
                                  ? RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: AppColors.greenColorGradient,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  : null,
                          color: AppColors.primary,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                bottom: -20,
                                right: 30,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent),
                                  child: Opacity(
                                    opacity: 0.1,
                                    child: Transform.rotate(
                                      angle: -0.5,
                                      child: Icon(
                                        transaction.paymentType ==
                                                PaymentTypeEnum.cash.label
                                            ? FontAwesomeIcons.moneyBill
                                            : FontAwesomeIcons.creditCard,
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    transaction.expenseType ==
                                            ExpenseTypeEnum.income.label
                                        ? Icon(IncomeCategory.returnIcon(
                                            transaction.category))
                                        : Icon(ExpenseCategory.returnIcon(
                                            transaction.category)),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        transaction.title,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(transaction.date),
                                trailing: Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 100,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.textSecondaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: transaction.expenseType ==
                                                ExpenseTypeEnum.expense.label ||
                                            transaction.expenseType ==
                                                ExpenseTypeEnum
                                                    .periodicExpense.label
                                        ? Text(
                                            ' - ${transaction.amount} PLN',
                                            style: TextAppTheme
                                                .textTheme.titleSmall!
                                                .copyWith(
                                                    color: Colors.redAccent),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            ' + ${transaction.amount} PLN',
                                            style: TextAppTheme
                                                .textTheme.titleSmall!
                                                .copyWith(
                                                    color: AppColors
                                                        .greenColorGradient),
                                            textAlign: TextAlign.center,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
