import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/expense_category_enum.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/enums/payment_type_enum.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/models/saving_goal_model.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddSavingAmountFormController extends GetxController {
  static AddSavingAmountFormController get instance => Get.find();

  var amount = TextEditingController();

  GlobalKey<FormState> savingAmountFormKey = GlobalKey<FormState>();
  final userRepository = UserRepository.instance;

  updateSavingGoalProgress(SavingGoalModel savingGoal) {
    var uuid = const Uuid();
    String savingGoalPaymentId = uuid.v4();
    try {
      if (!savingAmountFormKey.currentState!.validate()) {
        return;
      }

      Get.to(() => const FullScreenLoader());

      final parsedAmount = double.parse(amount.text.trim());

      if (parsedAmount > savingGoal.goal - savingGoal.currentAmount) {
        amount.text = (savingGoal.goal - savingGoal.currentAmount).toString();
        throw 'Wprowadziłeś zbyt dużą kwotę';
      }
      userRepository.addAmount(savingGoal.id, parsedAmount);

      String date = DateTime.now().toString().split(" ")[0];

      userRepository.addSavingGoalPayment(
          savingGoal, parsedAmount, date, savingGoalPaymentId);

      final ExpenseModel savingGoalExpense = ExpenseModel(
          id: savingGoalPaymentId,
          amount: parsedAmount,
          category: ExpenseCategory.savingsAndInvestments.label,
          date: date,
          description: 'Wpłata na cel oszczędnościowy ${savingGoal.title}',
          expenseType: ExpenseTypeEnum.expense.label,
          title: 'Cel oszczędnościowy',
          paymentType: PaymentTypeEnum.other.label);

      userRepository.addSavingGoalPaymentToTransactions(savingGoal,
          parsedAmount, date, savingGoalPaymentId, savingGoalExpense);

      userRepository.decrementCurrentBalance(parsedAmount);

      FullScreenLoader.stopLoading();
      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
