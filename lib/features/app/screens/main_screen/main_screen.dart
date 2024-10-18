import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/expense_details.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/expense_form.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/income_form.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(MainScreenController());
    // final controller = Get.put(BalanceController());

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                StreamBuilder(
                  stream: UserRepository.instance.streamTotalBalance(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Błąd: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text('Brak danych');
                    }

                    final totalBalance = snapshot.data ?? 0.0;
                    return Text('$totalBalance zł',
                        style: TextAppTheme.textTheme.headlineSmall);
                  },
                ),
                Text(
                  'Stan konta',
                  style: TextAppTheme.textTheme.labelSmall,
                ),
                const SizedBox(height: 70),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Wydatek',
                        height: 50,
                        width: 12,
                        redirection: (() => CustomDialog.customDialog(
                            icon: Icons.add,
                            widget: const ExpenseForm(),
                            subtitle: 'Podaj informacje o wydatku',
                            title: 'Dodaj wydatek')),
                        colorGradient1: AppColors.redColorGradient,
                        colorGradient2: AppColors.blueButton,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        text: 'Przychód',
                        height: 50,
                        width: 12,
                        redirection: (() => CustomDialog.customDialog(
                            icon: Icons.add,
                            widget: const IncomeForm(),
                            subtitle: 'Podaj informacje o przychodzie',
                            title: 'Dodaj przychód')),
                        colorGradient1: AppColors.greenColorGradient,
                        colorGradient2: AppColors.blueButton,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.secondary, // Set your custom background color
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Moje transakcje',
                    style: TextAppTheme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: StreamBuilder<List<ExpenseModel>>(
                      stream: UserRepository.instance.streamAllTransactions(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Błąd: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.question_mark_rounded,
                                  color: AppColors.textSecondaryColor,
                                  size: 50,
                                ),
                                SizedBox(height: 20),
                                Text('Nie masz jeszcze żadnych transakcji'),
                              ],
                            ),
                          );
                        }

                        final transactions = snapshot.data!;

                        return Skeletonizer(
                          enabled: snapshot.connectionState ==
                              ConnectionState.waiting,
                          effect: const ShimmerEffect(
                            baseColor: AppColors.onBoarding3,
                            highlightColor: Colors.grey,
                            duration: Duration(seconds: 2),
                          ),
                          child: ListView.builder(
                            itemCount:
                                transactions.length, // Example item count
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];

                              return GestureDetector(
                                onLongPress: () => CustomDialog.customDialog(
                                  icon: Icons.monetization_on_outlined,
                                  title: transaction.title,
                                  subtitle: transaction.description,
                                  widget:
                                      ExpenseDetails(transaction: transaction),
                                ),
                                child: Dismissible(
                                  key: Key(transaction.id),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) async {
                                    await UserRepository.instance.deleteExpense(
                                        transaction.expenseType,
                                        transaction.id,
                                        transaction.amount);

                                    Snackbars.infoSnackbar(
                                        title: 'Usunięto!',
                                        message: '${transaction.amount}');
                                  },
                                  background: Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColors.deleteExpenseColor
                                          .withOpacity(0.5),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(
                                        Icons.delete_outline_rounded,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  child: Card(
                                    shape: transaction.expenseType ==
                                            ExpenseTypeEnum
                                                .periodicExpense.label
                                        ? RoundedRectangleBorder(
                                            side: const BorderSide(
                                              color:
                                                  AppColors.deleteExpenseColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )
                                        : transaction.expenseType ==
                                                ExpenseTypeEnum
                                                    .periodicIncome.label
                                            ? RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  color: AppColors
                                                      .greenColorGradient,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )
                                            : null,
                                    color: AppColors.primary,
                                    child: ListTile(
                                      title: Text(transaction.title),
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: transaction.expenseType ==
                                                      ExpenseTypeEnum
                                                          .expense.label ||
                                                  transaction.expenseType ==
                                                      ExpenseTypeEnum
                                                          .periodicExpense.label
                                              ? Text(
                                                  ' - ${transaction.amount} zł',
                                                  style: TextAppTheme
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color:
                                                              Colors.redAccent))
                                              : Text(
                                                  ' + ${transaction.amount} zł',
                                                  style: TextAppTheme
                                                      .textTheme.titleSmall,
                                                  textAlign: TextAlign.center,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
