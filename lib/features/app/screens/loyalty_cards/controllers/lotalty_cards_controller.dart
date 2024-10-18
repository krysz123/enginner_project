import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:enginner_project/features/app/screens/loyalty_cards/widgets/save_card_name.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyaltyCardsController extends GetxController {
  static LoyaltyCardsController get instance => Get.find();
  Rx<String> code = 'sdf'.obs;

  GlobalKey<FormState> saveCardFormKey = GlobalKey<FormState>();

  final title = TextEditingController();

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan(
        options: const ScanOptions(
          strings: {
            'cancel': 'Cofnij',
            'flash_on': 'Włącz latarke',
            'flash_off': 'Wyłącz latarke',
          },
        ),
      );
      code.value = result.rawContent;

      if (code.value != '') {
        Get.to(SaveCardTitle(code: code.value));
      }
    } catch (e) {
      Snackbars.errorSnackbar(title: 'Błąd', message: e);
    }
  }
}
