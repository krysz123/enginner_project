import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/charts/widgets/single_chart.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ListCharts {
  List<Widget> get chartList {
    List<LineChartBarData> getBarsData(List<ExpenseModel> allTransactions) {
      return [
        LineChartBarData(
          spots: allTransactions
              .asMap()
              .map(
                (index, e) => MapEntry(
                  index,
                  FlSpot(index.toDouble(), e.amount),
                ),
              )
              .values
              .toList(),
          isCurved: false,
          barWidth: 3,
          color: AppColors.greenColorGradient,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.greenColorGradient.withOpacity(0.5),
                AppColors.greenColorGradient.withOpacity(0.03),
              ],
            ),
          ),
        ),
      ];
    }

    String getMonthName(int monthIndex) {
      const months = [
        'Styczeń',
        'Luty',
        'Marzec',
        'Kwiecień',
        'Maj',
        'Czerwiec',
        'Lipiec',
        'Sierpień',
        'Wrzesień',
        'Październik',
        'Listopad',
        'Grudzień'
      ];
      return months[monthIndex - 1];
    }

    String formatDate(String dateString) {
      DateTime date = DateTime.parse(dateString);
      return "${date.day} ${getMonthName(date.month)}";
    }

    FlTitlesData getTitlesData(List<ExpenseModel> allTransactions) {
      return FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 280,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < allTransactions.length) {
                final transaction = allTransactions[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    formatDate(transaction.date),
                    style: TextAppTheme.textTheme.titleSmall,
                  ),
                );
              }
              return const Text('');
            },
          ),
        ),
      );
    }

    double roundUpToNearest(double value) {
      return (value % 50 == 0) ? value : (50 * (value / 50).ceil()).toDouble();
    }

    double getMaxY(List<ExpenseModel> allTransactions) {
      return allTransactions.isNotEmpty
          ? roundUpToNearest(allTransactions
              .map((e) => e.amount)
              .reduce((a, b) => a > b ? a : b))
          : 10;
    }

    return [
      SingleChartScrenn(
        title: 'Wykres wydatków',
        stream: UserRepository.instance.streamOnlyExpenses(),
        buildChart: (allTransactions) => LineChart(
          LineChartData(
            lineBarsData: getBarsData(allTransactions),
            titlesData: getTitlesData(allTransactions),
            borderData: FlBorderData(show: false),
            maxY: getMaxY(allTransactions),
            minY: 0,
          ),
        ),
      ),
      SingleChartScrenn(
        title: 'Wykres przychodu',
        stream: UserRepository.instance.streamOnlyIncomes(),
        buildChart: (allTransactions) => LineChart(
          LineChartData(
            lineBarsData: getBarsData(allTransactions),
            titlesData: getTitlesData(allTransactions),
            borderData: FlBorderData(show: false),
            maxY: getMaxY(allTransactions),
            minY: 0,
          ),
        ),
      ),
      const Text('Siema'),
      const Text('Siema'),
      const Text('Siema'),
      const Text('Siema'),
      const Text('Siema'),
      const Text('Siema'),
      const Text('Siema'),
    ];
  }
}
