import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/expense_category_enum.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/enums/income_category_enum.dart';
import 'package:enginner_project/enums/payment_type_enum.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/controllers/shared_account_main_screen_controller.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/manage_shared_account.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_account_income_form.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_account_transaction_details.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_account_expense_form.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_account_transaction_filter_form.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SharedAccountMainScreen extends StatelessWidget {
  const SharedAccountMainScreen({super.key, required this.sharedAccount});

  final SharedAccountModel sharedAccount;

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(SharedAccountMainScreenController(sharedAccount.id));
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          title: Text(
            'Konto wspólne: ${sharedAccount.title}',
            style: TextAppTheme.textTheme.titleMedium,
          ),
          backgroundColor: Colors.transparent,
          forceMaterialTransparency: true,
          elevation: 0,
          actions: [
            sharedAccount.owner ==
                    AuthenticationRepository.instance.authUser!.email!
                ? IconButton(
                    onPressed: () => Get.to(
                      () => ManageSharedAccountScreen(
                          sharedAccount: sharedAccount),
                    ),
                    icon: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                  )
                : IconButton(
                    onPressed: () => CustomDialog.customDialog(
                        title: 'Opuść konto wspólne',
                        subtitle:
                            'Czy na pewno chcesz opuścić konto wspólne ${sharedAccount.title}',
                        widget: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                  text: 'Cofnij',
                                  height: 50,
                                  width: 30,
                                  redirection: () => Get.back(),
                                  colorGradient1: AppColors.loginBackgorund1,
                                  colorGradient2: AppColors.blueButton),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomButton(
                                  text: 'Opuść',
                                  height: 50,
                                  width: 30,
                                  redirection: () {
                                    UserRepository.instance
                                        .rejectInviteToSharedAccount(
                                            AuthenticationRepository
                                                .instance.authUser!.uid,
                                            sharedAccount.id);
                                    Get.back();
                                  },
                                  colorGradient1: AppColors.blueButton,
                                  colorGradient2: AppColors.redColorGradient),
                            )
                          ],
                        ),
                        icon: FontAwesomeIcons.arrowRightToBracket),
                    icon: const Icon(FontAwesomeIcons.arrowRightToBracket),
                  )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: UserRepository.instance
                          .streamSharedAccountTotalBalance(sharedAccount.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Wydatek',
                            height: 50,
                            width: 12,
                            redirection: (() => CustomDialog.customDialog(
                                icon: Icons.add,
                                widget: SharedAccountExpenseForm(
                                    sharedAccountId: sharedAccount.id),
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
                                widget: SharedAccountIncomeForm(
                                    sharedAccountId: sharedAccount.id),
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
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: const BoxDecoration(
                    color:
                        AppColors.secondary, // Set your custom background color
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Wspólne transakcje',
                            style: TextAppTheme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          OutlinedButton(
                              onPressed: () => CustomDialog.customDialog(
                                    title: 'Filtruj transakcje',
                                    subtitle: 'Wybierz dane do filtracji',
                                    widget:
                                        const SharedAccountTransactionFilterForm(),
                                    icon: FontAwesomeIcons.filter,
                                  ),
                              child: const Text('Filtr'))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Expanded(
                          child: ListView.builder(
                            itemCount: controller.filteredExpenses.length,
                            itemBuilder: (context, index) {
                              final transaction =
                                  controller.filteredExpenses[index];

                              return GestureDetector(
                                onLongPress: () => CustomDialog.customDialog(
                                  icon: Icons.monetization_on_outlined,
                                  title: transaction.title,
                                  subtitle: transaction.description,
                                  widget: SharedAccountTransactionDetails(
                                      sharedAccountTransaction: transaction),
                                ),
                                child: Dismissible(
                                  key: Key(transaction.id),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) async {
                                    await UserRepository.instance
                                        .deleteSharedAccountExpense(
                                      transaction.id,
                                      sharedAccount.id,
                                      transaction.expenseType,
                                      transaction.amount,
                                    );

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
                                              opacity: 0.05,
                                              child: Transform.rotate(
                                                angle: -0.5,
                                                child: Icon(
                                                  transaction.paymentType ==
                                                          PaymentTypeEnum
                                                              .cash.label
                                                      ? FontAwesomeIcons
                                                          .moneyBill
                                                      : FontAwesomeIcons
                                                          .creditCard,
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
                                                      ExpenseTypeEnum
                                                          .income.label
                                                  ? Icon(
                                                      IncomeCategory.returnIcon(
                                                          transaction.category))
                                                  : Icon(ExpenseCategory
                                                      .returnIcon(transaction
                                                          .category)),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                child: Text(
                                                  transaction.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(transaction.sender),
                                              Text(transaction.date),
                                            ],
                                          ),
                                          trailing: Container(
                                            constraints: const BoxConstraints(
                                              minWidth: 100,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors
                                                    .textSecondaryColor,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: transaction.expenseType ==
                                                          ExpenseTypeEnum
                                                              .expense.label ||
                                                      transaction.expenseType ==
                                                          ExpenseTypeEnum
                                                              .periodicExpense
                                                              .label
                                                  ? Text(
                                                      ' - ${transaction.amount} zł',
                                                      style: TextAppTheme
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Colors
                                                                  .redAccent))
                                                  : Text(
                                                      ' + ${transaction.amount} zł',
                                                      style: TextAppTheme
                                                          .textTheme.titleSmall,
                                                      textAlign:
                                                          TextAlign.center,
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
