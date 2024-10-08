import 'package:enginner_project/enums/chart_date_option_enum.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:get/get.dart';

class ChartsController extends GetxController {
  static ChartsController get instance => Get.find();

  Rx<ChartDateOptionEnum> selectedView = ChartDateOptionEnum.week.obs;

  List<ExpenseModel> filterTransactions(List<ExpenseModel> transactions) {
    final now = DateTime.now();

    switch (selectedView.value) {
      case ChartDateOptionEnum.month:
        return transactions
            .where((t) => DateTime.parse(t.date)
                .isAfter(now.subtract(const Duration(days: 31))))
            .toList();

      case ChartDateOptionEnum.year:
        return transactions
            .where((t) => DateTime.parse(t.date)
                .isAfter(now.subtract(const Duration(days: 365))))
            .toList();
      case ChartDateOptionEnum.week:
      default:
        return transactions
            .where((t) => DateTime.parse(t.date)
                .isAfter(now.subtract(const Duration(days: 7))))
            .toList();
    }
  }
}
