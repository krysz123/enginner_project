import 'package:flutter/material.dart';

enum ExpenseTypeEnum {
  expense('Wydatek', Icons.shopping_cart),
  income('Przychód', Icons.attach_money),
  periodicExpense('Wydatek stały', Icons.repeat),
  periodicIncome('Przychód stały', Icons.autorenew);

  final String label;
  final IconData icon;

  const ExpenseTypeEnum(this.label, this.icon);

  static IconData returnIcon(String label) {
    return ExpenseTypeEnum.values
        .firstWhere(
          (category) => category.label == label,
        )
        .icon;
  }
}
