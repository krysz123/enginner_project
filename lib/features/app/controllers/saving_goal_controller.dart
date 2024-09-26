import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/models/saving_goal_model.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SavingGoalFormController extends GetxController {
  static SavingGoalFormController get instance => Get.find();

  final title = TextEditingController();
  final goal = TextEditingController();
  final description = TextEditingController();

  GlobalKey<FormState> savingGoalFormKey = GlobalKey<FormState>();
  final userRepository = UserRepository.instance;

  saveSavingGoal() async {
    var uuid = const Uuid();
    String savingGoalId = uuid.v4();
    try {
      if (!savingGoalFormKey.currentState!.validate()) {
        return;
      }

      Get.to(() => const FullScreenLoader());

      final parseGoal = double.parse(goal.text.trim());

      final newSavingGoal = SavingGoalModel(
          id: savingGoalId,
          title: title.text.trim(),
          currentAmount: 0,
          goal: parseGoal,
          status: false,
          description: description.text.trim());

      await userRepository.saveSavingGoal(newSavingGoal);

      FullScreenLoader.stopLoading();
      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
