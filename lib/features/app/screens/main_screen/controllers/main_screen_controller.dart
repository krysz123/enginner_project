import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  static MainScreenController get instance => Get.find();

  var expenses = <ExpenseModel>[].obs;
  var filteredExpenses = <ExpenseModel>[].obs;
  final title = TextEditingController();
  var minAmount = TextEditingController();
  var maxAmount = TextEditingController();
  var startingDate = TextEditingController();
  var endingDate = TextEditingController();

  GlobalKey<FormState> filterFormKey = GlobalKey<FormState>();
  var minAmountValue;
  var maxAmountValue;

  Rx<String> selectedPaymentType = ''.obs;
  Rx<String> selectedExpenseType = ''.obs;
  Rx<String> selectedExpenseCategory = ''.obs;
  Rx<String> selectedIncomeCategroy = ''.obs;

  @override
  void onInit() {
    super.onInit();
    streamAllExpenses();
  }

  changePaymentType(value) {
    selectedPaymentType.value = value;
  }

  changeExpenseType(value) {
    selectedExpenseType.value = value;
  }

  changeExpenseCategory(value) {
    selectedExpenseCategory.value = value;
  }

  changeIncomeCategory(value) {
    selectedIncomeCategroy.value = value;
  }

  void streamAllExpenses() {
    UserRepository.instance.streamAllTransactions().listen((list) {
      expenses.value = list;
      filteredExpenses.value = list;
    });
  }

  Future<void> selectStartingDate(context) async {
    DateTime? pickedStartingDate = await showDatePicker(
      cancelText: 'Anuluj',
      confirmText: 'Zatwierdź',
      helpText: 'Wybierz początkową date',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedStartingDate != null) {
      startingDate.text = pickedStartingDate.toString().split(" ")[0];
    }
  }

  Future<void> selectEndingDate(context) async {
    DateTime? pickedEndingDate = await showDatePicker(
      cancelText: 'Anuluj',
      confirmText: 'Zatwierdź',
      helpText: 'Wybierz końcową date',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedEndingDate != null) {
      endingDate.text = pickedEndingDate.toString().split(" ")[0];
    }
  }

  void resetFilters() {
    filteredExpenses.value = expenses;
    title.clear();
    minAmount.clear();
    maxAmount.clear();

    selectedPaymentType.value = '';
    selectedExpenseType.value = '';
    selectedExpenseCategory.value = '';
    selectedIncomeCategroy.value = '';
    startingDate.text = '';
    endingDate.text = '';
  }

  checkCategories() {
    if (selectedExpenseCategory.value != '' &&
        selectedIncomeCategroy.value != '') {
      throw 'Możesz wybrać tylko jedną z kategroii';
    } else if (selectedExpenseCategory.value != '' &&
        selectedExpenseType.value == ExpenseTypeEnum.income.label) {
      throw 'Wybierz odpowiedni typ lub kategorię';
    } else if (selectedIncomeCategroy.value != '' &&
        selectedExpenseType.value == ExpenseTypeEnum.expense.label) {
      throw 'Wybierz odpowiedni typ lub kategorię';
    }
  }

  void filterTransactions(String title) async {
    try {
      if (!filterFormKey.currentState!.validate()) {
        return;
      }

      if (minAmount.text.isEmpty) {
        minAmountValue = double.negativeInfinity;
      } else {
        minAmountValue = double.parse(minAmount.text);
      }

      if (maxAmount.text.isEmpty) {
        maxAmountValue = double.infinity;
      } else {
        maxAmountValue = double.parse(maxAmount.text);
      }

      if (startingDate.text == '') {
        startingDate.text = DateTime(2000).toString().split(" ")[0];
      }
      if (endingDate.text == '') {
        endingDate.text = DateTime.now().toString().split(" ")[0];
      }

      if (!DateTime.parse(startingDate.text)
          .isBefore(DateTime.parse(endingDate.text))) {
        throw 'Wybierz poprawny przedział czasowy';
      }

      print(startingDate.text);
      print(endingDate.text);

      filteredExpenses.value = expenses.where((transaction) {
        final matchesTitles =
            title.isEmpty || transaction.title.contains(title);
        final matchesAmount = transaction.amount >= minAmountValue &&
            transaction.amount <= maxAmountValue;

        final matchesPaymentType = selectedPaymentType.value.isEmpty ||
            transaction.paymentType == selectedPaymentType.value;

        final matchesExpenseType = selectedExpenseType.value.isEmpty ||
            transaction.expenseType == selectedExpenseType.value;

        checkCategories();
        final matchesExpenseCategroy = selectedExpenseCategory.value.isEmpty ||
            transaction.category == selectedExpenseCategory.value;
        final matchesIncomeCategroy = selectedIncomeCategroy.value.isEmpty ||
            transaction.category == selectedIncomeCategroy.value;

        final matchesDate = DateTime.parse(transaction.date)
                .isAfter(DateTime.parse(startingDate.text)) &&
            DateTime.parse(transaction.date).isBefore(
                DateTime.parse(endingDate.text).add(const Duration(days: 1)));

        return matchesTitles &&
            matchesAmount &&
            matchesPaymentType &&
            matchesExpenseType &&
            matchesExpenseCategroy &&
            matchesIncomeCategroy &&
            matchesDate;
      }).toList();

      if (startingDate.text == '') {
        startingDate.clear();
      }
      if (endingDate.text == '') {
        endingDate.clear();
      }
      Get.back();
    } catch (e) {
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
