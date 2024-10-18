import 'package:enginner_project/enums/debts_types_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DebtsScreenController extends GetxController {
  static DebtsScreenController get instance => Get.find();

  final values = RxList<bool>([true, false]);

  RxBool isClaimSelected = true.obs;
  RxBool isDebtSelected = false.obs;

  final type = Rx<String>(DebtsTypesEnum.claims.label);
  final List<String> values2 = [
    DebtsTypesEnum.claims.label,
    DebtsTypesEnum.debts.label,
  ];

  final title = TextEditingController();
  final description = TextEditingController();
  final amount = TextEditingController();

  GlobalKey<FormState> newDebtFormKey = GlobalKey<FormState>();

  void switchValues(int index) {
    for (var i = 0; i < values.length; i++) {
      values[i] = false;
    }
    values[index] = true;
    type.value = values2[index];
    print(type.value);
  }
}
