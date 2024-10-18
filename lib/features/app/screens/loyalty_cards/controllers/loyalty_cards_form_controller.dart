import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/models/loyalty_card_model.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class LoyaltyCardsFormController extends GetxController {
  static LoyaltyCardsFormController get instance => Get.find();

  GlobalKey<FormState> saveCardFormKey = GlobalKey<FormState>();
  final title = TextEditingController();

  final userRepository = UserRepository.instance;

  void saveCard(String code) async {
    var uuid = const Uuid();
    String cardId = uuid.v4();

    try {
      if (!saveCardFormKey.currentState!.validate()) {
        return;
      }
      Get.to(() => const FullScreenLoader());

      final newCard = LoyaltyCardModel(
        id: cardId,
        title: title.text.trim(),
        code: code,
      );

      userRepository.saveLoyaltyCard(newCard);

      FullScreenLoader.stopLoading();
      title.clear();
      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
