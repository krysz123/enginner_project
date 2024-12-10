import 'dart:math';
import 'package:enginner_project/features/app/screens/charts/widgets/common_stats_widget.dart';
import 'package:enginner_project/features/app/screens/charts/widgets/common_stats_with_percent_widget.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesSummaryChart extends StatelessWidget {
  const ExpensesSummaryChart({
    super.key,
    required this.allFilteredTransactions,
    required this.allTransactions,
  });

  final List<ExpenseModel> allFilteredTransactions;
  final List<ExpenseModel> allTransactions;

  @override
  Widget build(BuildContext context) {
// Suma wydatków
    final double sumFilteredValues = allFilteredTransactions.fold(
        0.0, (sum, transaction) => sum + transaction.amount);

    final double sumAllValues = allTransactions.fold(
        0.0, (sum, transaction) => sum + transaction.amount);

// Liczba transakcji
    final numberOfFilteredValues = allFilteredTransactions.length;
    final numberOfValues = allTransactions.length;

// Maksymalna i minimalna wartość dla przefiltrowanych transakcji
    final double maxFilteredValue = allFilteredTransactions.isNotEmpty
        ? allFilteredTransactions.map((e) => e.amount).reduce(max)
        : 0.0;

    final double minFilteredValue = allFilteredTransactions.isNotEmpty
        ? allFilteredTransactions.map((e) => e.amount).reduce(min)
        : 0.0;

// Maksymalna i minimalna wartość dla wszystkich transakcji
    final double maxValue = allTransactions.isNotEmpty
        ? allTransactions.map((e) => e.amount).reduce(max)
        : 0.0;

    final double minValue = allTransactions.isNotEmpty
        ? allTransactions.map((e) => e.amount).reduce(min)
        : 0.0;

    return Column(
      children: [
        CommonStatsWithPercentWidget(
          allValues: sumAllValues,
          filteredValues: sumFilteredValues,
          mark: ' PLN',
          title: 'Suma wydatków',
          percent: sumFilteredValues / sumAllValues,
        ),
        CommonStatsWithPercentWidget(
          filteredValues: numberOfFilteredValues,
          allValues: numberOfValues,
          title: 'Liczba transakcji',
          mark: '',
          percent: numberOfFilteredValues / numberOfValues,
        ),
        CommonStatsWithPercentWidget(
          filteredValues: maxFilteredValue,
          allValues: maxValue,
          title: 'Maksymalna wartość transakcji',
          mark: 'PLN',
          percent: maxFilteredValue / maxValue,
        ),
        CommonStatsWithPercentWidget(
          filteredValues: minFilteredValue,
          allValues: minValue,
          title: 'Minimalna wartość transakcji',
          mark: 'PLN',
          percent: minFilteredValue / minValue,
        ),
        CommonStatsWidget(
          filteredValues: numberOfFilteredValues,
          allValues: numberOfValues,
          title: 'Średnia wartość transakcji',
          mark: 'PLN',
          value:
              (sumFilteredValues / numberOfFilteredValues).toStringAsFixed(2),
        ),
        // CommonStatsWidget(
        //   filteredValues: sumFilteredValues,
        //   allValues: sumAllValues,
        //   title: 'Średnia wartość transakcji',
        //   mark: 'PLN',
        //   value: sumFilteredValues / numberOfFilteredValues,
        // ),
        // CommonStatsWidget(
        //   filteredValues: sumFilteredValues,
        //   allValues: sumAllValues,
        //   title: 'Maksymalna wartość transakcji',
        //   mark: 'PLN',
        //   value: maxValue,
        // ),
        // CommonStatsWidget(
        //   filteredValues: sumFilteredValues,
        //   allValues: sumAllValues,
        //   title: 'Minimalna wartość transakcji',
        //   mark: 'PLN',
        //   value: minValue,
        // ),
      ],
    );
  }
}
