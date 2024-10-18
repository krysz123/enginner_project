import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/debts_types_enum.dart';
import 'package:enginner_project/models/debt_model.dart';
import 'package:enginner_project/models/friend_model.dart';
import 'package:enginner_project/utils/device/network_connection.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NewDebtFormController extends GetxController {
  static NewDebtFormController get instance => Get.find();

  final title = TextEditingController();
  final description = TextEditingController();
  final amount = TextEditingController();

  GlobalKey<FormState> newDebtFormKey = GlobalKey<FormState>();
  final userRepository = UserRepository.instance;

  saveNewDebt(String friendId) async {
    try {
      if (!newDebtFormKey.currentState!.validate()) {
        return;
      }
      final isConnected = await NetworkConnection.instance.isConnected();
      if (!isConnected) {
        throw 'Brak połączenia z internetem';
      }
      Get.to(() => const FullScreenLoader());

      final parseAmount = double.parse(amount.text.trim());

      final savingNewDebt = DebtModel(
          description: description.text,
          title: title.text,
          amount: parseAmount,
          type: '',
          status: false,
          timestamp: Timestamp.now());

      await userRepository.saveNewDebt(friendId, savingNewDebt);

      FullScreenLoader.stopLoading();
      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
