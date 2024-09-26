import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/models/saving_goal_model.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSavingAmountFormController extends GetxController {
  static AddSavingAmountFormController get instance => Get.find();

  final amount = TextEditingController();

  GlobalKey<FormState> savingAmountFormKey = GlobalKey<FormState>();
  final userRepository = UserRepository.instance;

  updateSavingGoalProgress(SavingGoalModel savingGoal) {
    try {
      if (!savingAmountFormKey.currentState!.validate()) {
        return;
      }

      Get.to(() => const FullScreenLoader());

      final parsedAmount = double.parse(amount.text.trim());

      userRepository.addAmount(savingGoal.id, parsedAmount);

      if (savingGoal.currentAmount + parsedAmount >= savingGoal.goal) {
        Map<String, dynamic> endedGoal = {'Status': true};

        userRepository.updateEndedSavingGoal(endedGoal, savingGoal.id);
      }

      FullScreenLoader.stopLoading();
      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
