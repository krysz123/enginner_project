import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_account_expense_form.dart';
import 'package:enginner_project/models/shared_account_expense_model.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedAccountMainScreenController extends GetxController {
  static SharedAccountMainScreenController get instance => Get.find();
  final userRepository = UserRepository.instance;

  SharedAccountMainScreenController(this.sharedAccountId);
  final String sharedAccountId;

  var expenses = <SharedAccountExpenseModel>[].obs;
  var filteredExpenses = <SharedAccountExpenseModel>[].obs;
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
  Rx<String> selectedUserName = ''.obs;

  var users = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    streamAllExpenses();
    findUsers();
  }

  Future<void> findUsers() async {
    List<Map<String, String>> fetchedUsers = await UserRepository.instance
        .fetchUsersToSharedAccount(sharedAccountId, true);
    users.value = fetchedUsers;
  }

  changePaymentType(value) {
    selectedPaymentType.value = value;
  }

  changeUser(value) {
    selectedUserName.value = value;
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
    UserRepository.instance
        .streamAllSharedAccountTransactions(sharedAccountId)
        .listen((list) {
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
    selectedUserName.value = '';
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

        final matchesUser = selectedUserName.value.isEmpty ||
            transaction.sender == selectedUserName.value;

        return matchesTitles &&
            matchesAmount &&
            matchesPaymentType &&
            matchesExpenseType &&
            matchesExpenseCategroy &&
            matchesIncomeCategroy &&
            matchesDate &&
            matchesUser;
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
