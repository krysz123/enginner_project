import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartDateFilterFormController extends GetxController {
  static ChartDateFilterFormController get instance => Get.find();

  GlobalKey<FormState> chartFilterFormKey = GlobalKey<FormState>();
  var startingDate = TextEditingController();
  var endingDate = TextEditingController();

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
}
