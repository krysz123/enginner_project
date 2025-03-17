import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/models/shared_account_expense_model.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SharedAccountTransactionFormController extends GetxController {
  static SharedAccountTransactionFormController get instance => Get.find();

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
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      time.text = pickedDate.toString().split(" ")[0];
    }
  }

  void saveExpense(String sharedAccountId) async {
    var uuid = const Uuid();
    String transactionId = uuid.v4();

    try {
      if (!expenseFormKey.currentState!.validate()) {
        return;
      }

      Get.to(() => const FullScreenLoader());

      final parsedAmount = double.parse(amount.text.trim());

      final newExpense = SharedAccountExpenseModel(
        id: transactionId,
        title: title.text.trim(),
        amount: parsedAmount,
        category: selectedCategory.trim(),
        date: time.text.trim(),
        description: description.text.trim(),
        expenseType: ExpenseTypeEnum.expense.label,
        paymentType: selectedPaymentType.trim(),
        sender: UserController.instance.user.value.fullname,
      );

      userRepository.saveSharedAccountExpense(newExpense, sharedAccountId);
      userRepository.decrementSharedAccountCurrentBalance(
          parsedAmount, sharedAccountId);
      FullScreenLoader.stopLoading();

      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }

  void saveIncome(String sharedAccountId) async {
    var uuid = const Uuid();
    String transactionId = uuid.v4();

    try {
      if (!expenseFormKey.currentState!.validate()) {
        return;
      }

      Get.to(() => const FullScreenLoader());

      final parsedAmount = double.parse(amount.text.trim());

      final newExpense = SharedAccountExpenseModel(
        id: transactionId,
        title: title.text.trim(),
        amount: parsedAmount,
        category: selectedCategory.trim(),
        date: time.text.trim(),
        description: description.text.trim(),
        expenseType: ExpenseTypeEnum.income.label,
        paymentType: selectedPaymentType.trim(),
        sender: UserController.instance.user.value.fullname,
      );

      userRepository.saveSharedAccountExpense(newExpense, sharedAccountId);
      userRepository.incrementSharedAccountCurrentBalance(
          parsedAmount, sharedAccountId);
      FullScreenLoader.stopLoading();

      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
