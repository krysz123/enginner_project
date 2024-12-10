import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/enums/payment_type_enum.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:get/get.dart';

class CategoriesSummaryController extends GetxController {
  static CategoriesSummaryController get instance => Get.find();

  RxMap<String, int> incomesCount = <String, int>{}.obs;
  RxMap<String, int> expensesCount = <String, int>{}.obs;
  RxMap<String, int> cashCount = <String, int>{}.obs;
  RxMap<String, int> cardCount = <String, int>{}.obs;

  RxMap<String, double> incomesSum = <String, double>{}.obs;
  RxMap<String, double> expensesSum = <String, double>{}.obs;
  RxMap<String, double> cashSum = <String, double>{}.obs;
  RxMap<String, double> cardSum = <String, double>{}.obs;

  void countCategories(List<ExpenseModel> expenses) {
    Map<String, int> incomeMap = {};
    Map<String, int> expenseMap = {};
    Map<String, int> cashMap = {};
    Map<String, int> cardMap = {};

    Map<String, double> incomeSumMap = {};
    Map<String, double> expenseSumMap = {};
    Map<String, double> cashSumMap = {};
    Map<String, double> cardSumMap = {};

    for (var expense in expenses) {
      // Zliczanie kategorii i sumowanie wartości dla przychodów
      if (expense.expenseType == ExpenseTypeEnum.income.label ||
          expense.expenseType == ExpenseTypeEnum.periodicIncome.label) {
        incomeMap[expense.category] = (incomeMap[expense.category] ?? 0) + 1;
        incomeSumMap[expense.category] =
            (incomeSumMap[expense.category] ?? 0) + expense.amount;
      }

      // Zliczanie kategorii i sumowanie wartości dla wydatków
      else if (expense.expenseType == ExpenseTypeEnum.expense.label ||
          expense.expenseType == ExpenseTypeEnum.periodicExpense.label) {
        expenseMap[expense.category] = (expenseMap[expense.category] ?? 0) + 1;
        expenseSumMap[expense.category] =
            (expenseSumMap[expense.category] ?? 0) + expense.amount;
      }

      // Zliczanie kategorii i sumowanie wartości dla gotówki
      if (expense.paymentType == PaymentTypeEnum.cash.label) {
        cashMap[expense.category] = (cashMap[expense.category] ?? 0) + 1;
        cashSumMap[expense.category] =
            (cashSumMap[expense.category] ?? 0) + expense.amount;
      }

      // Zliczanie kategorii i sumowanie wartości dla karty
      else if (expense.paymentType == PaymentTypeEnum.card.label) {
        cardMap[expense.category] = (cardMap[expense.category] ?? 0) + 1;
        cardSumMap[expense.category] =
            (cardSumMap[expense.category] ?? 0) + expense.amount;
      }
    }

    // Przypisanie wyników do zmiennych reaktywnych
    incomesCount.assignAll(incomeMap);
    expensesCount.assignAll(expenseMap);
    cashCount.assignAll(cashMap);
    cardCount.assignAll(cardMap);

    incomesSum.assignAll(incomeSumMap);
    expensesSum.assignAll(expenseSumMap);
    cashSum.assignAll(cashSumMap);
    cardSum.assignAll(cardSumMap);
  }
}
