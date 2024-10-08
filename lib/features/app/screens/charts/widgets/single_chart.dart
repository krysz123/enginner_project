import 'package:enginner_project/features/app/controllers/charts_controller.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleChartScrenn extends StatelessWidget {
  const SingleChartScrenn({
    super.key,
    required this.title,
    required this.stream,
    required this.buildChart,
  });

  final String title;
  final Stream<List<ExpenseModel>> stream;
  final Widget Function(List<ExpenseModel>) buildChart;

  @override
  Widget build(BuildContext context) {
    final controller = ChartsController.instance;
    return Column(
      children: [
        Text(
          title,
          style: TextAppTheme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: StreamBuilder<List<ExpenseModel>>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Błąd: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.question_mark_rounded,
                        color: AppColors.textSecondaryColor,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text('Brak danych'),
                    ],
                  ),
                );
              }

              return Obx(() {
                final allTransactions =
                    controller.filterTransactions(snapshot.data!);
                return buildChart(allTransactions);
              });
            },
          ),
        ),
      ],
    );
  }
}
