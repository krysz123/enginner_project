import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ExpenseFormController extends GetxController {
  static ExpenseFormController get instance => Get.find();

  final title = TextEditingController();
  final amount = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  final expenseType = TextEditingController();
  final time = TextEditingController();

  Rx<String> selectedCategory = ''.obs;
  Rx<String> selectedPaymentType = ''.obs;

  Rx<bool> isChecked = false.obs;

  GlobalKey<FormState> expenseFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> incomeFormKey = GlobalKey<FormState>();

  final userController = UserController.instance;
  final userRepository = UserRepository.instance;

  changeCheckbox(value) {
    isChecked.value = value;
  }

  changeCategory(value) {
    selectedCategory.value = value;
  }

  changePaymentType(value) {
    selectedPaymentType.value = value;
  }

  Future<void> selectDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      cancelText: 'Anuluj',
      confirmText: 'Zatwierdź',
      helpText: 'Wybierz date',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      time.text = pickedDate.toString().split(" ")[0];
    }
  }

  void saveExpense() async {
    var uuid = const Uuid();
    String transactionId = uuid.v4();
    try {
      if (!expenseFormKey.currentState!.validate()) {
        return;
      }

      Get.to(() => const FullScreenLoader());

      final parsedAmount = double.parse(amount.text.trim());

      final newExpense = ExpenseModel(
        id: transactionId,
        title: title.text.trim(),
        amount: parsedAmount,
        category: selectedCategory.trim(),
        date: time.text.trim(),
        description: description.text.trim(),
        expenseType: 'Wydatek',
        paymentType: selectedPaymentType.trim(),
      );
      await userRepository.saveExpenseRecord(newExpense);
      // final balanceController = BalanceController.instance;
      final balance = userController.totalBalance.value - parsedAmount;

      userController.user.update((user) {
        user!.totalBalance -= parsedAmount;
      });

      Map<String, dynamic> expense = {'TotalBalance': balance};
      await userRepository.updateSingleField(expense);

      if (isChecked.value) {
        userController.addExpenseMonthlyTask(transactionId, newExpense);
      }

      FullScreenLoader.stopLoading();

      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }

  void saveIncome() async {
    var uuid = const Uuid();
    String transactionId = uuid.v4();
    try {
      if (!incomeFormKey.currentState!.validate()) {
        return;
      }

      Get.to(() => const FullScreenLoader());

      final parsedAmount = double.parse(amount.text.trim());

      final newIncome = ExpenseModel(
        id: transactionId,
        amount: parsedAmount,
        category: selectedCategory.trim(),
        date: time.text.trim(),
        description: description.text.trim(),
        expenseType: 'Przychód',
        title: title.text.trim(),
        paymentType: selectedPaymentType.trim(),
      );

      await userRepository.saveExpenseRecord(newIncome);
      final balance = userController.totalBalance.value + parsedAmount;

      userController.user.update(
        (user) {
          user!.totalBalance += parsedAmount;
        },
      );

      Map<String, dynamic> income = {'TotalBalance': balance};
      await userRepository.updateSingleField(income);

      if (isChecked.value) {
        userController.addIncomeMonthlyTask(transactionId, newIncome);
      }

      FullScreenLoader.stopLoading();

      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
