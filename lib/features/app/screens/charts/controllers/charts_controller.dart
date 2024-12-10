import 'package:enginner_project/enums/chart_date_option_enum.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartsController extends GetxController {
  static ChartsController get instance => Get.find();

  Rx<ChartDateOptionEnum> selectedView = ChartDateOptionEnum.week.obs;

  Rx<int> currentPage = 0.obs;
  final pageViewController = PageController();

  void updatePage(int index) => currentPage.value = index;
  GlobalKey<FormState> chartFilterFormKey = GlobalKey<FormState>();
  var startingDate = TextEditingController();
  var endingDate = TextEditingController();

  String pickedStartingDate = '';
  String pickedEndingDate = '';

  void resetFilters() {
    startingDate.text = '';
    endingDate.text = '';
  }

  List<ExpenseModel> filterTransactions(List<ExpenseModel> transactions) {
    final now = DateTime.now();

    switch (selectedView.value) {
      case ChartDateOptionEnum.custom:
        try {
          // if (!chartFilterFormKey.currentState!.validate()) {
          //   throw 'Siema';
          // }

          if (startingDate.text == '') {
            pickedStartingDate = DateTime(2000).toString().split(" ")[0];
          } else {
            pickedStartingDate = startingDate.text;
          }
          if (endingDate.text == '') {
            pickedEndingDate = DateTime.now().toString().split(" ")[0];
          } else {
            pickedEndingDate = endingDate.text;
          }
          if (!DateTime.parse(pickedStartingDate)
              .isBefore(DateTime.parse(pickedEndingDate))) {
            return [];
          } else {
            return transactions
                .where((t) =>
                    DateTime.parse(t.date)
                        .isAfter(DateTime.parse(pickedStartingDate)) &&
                    DateTime.parse(t.date).isBefore(
                        DateTime.parse(pickedEndingDate)
                            .add(const Duration(days: 1))))
                .toList();
          }
        } finally {
          Get.back();
        }

      case ChartDateOptionEnum.month:
        resetFilters();
        return transactions
            .where((t) => DateTime.parse(t.date)
                .isAfter(now.subtract(const Duration(days: 31))))
            .toList();

      case ChartDateOptionEnum.year:
        resetFilters();
        return transactions
            .where((t) => DateTime.parse(t.date)
                .isAfter(now.subtract(const Duration(days: 365))))
            .toList();
      case ChartDateOptionEnum.week:
      default:
        resetFilters();
        return transactions
            .where((t) => DateTime.parse(t.date)
                .isAfter(now.subtract(const Duration(days: 7))))
            .toList();
    }
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
}
