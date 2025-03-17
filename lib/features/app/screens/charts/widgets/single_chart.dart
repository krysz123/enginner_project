import 'package:enginner_project/features/app/screens/charts/controllers/charts_controller.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SingleChartScrenn extends StatelessWidget {
  const SingleChartScrenn({
    super.key,
    required this.title,
    required this.stream,
    required this.buildChart,
    required this.buildSummary,
  });

  final String title;
  final Stream<List<ExpenseModel>> stream;
  final Widget Function(List<ExpenseModel>) buildChart;
  final Widget Function(List<ExpenseModel> allFilteredTransactions,
      List<ExpenseModel> allTransactions) buildSummary;

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final controller = ChartsController.instance;
    return SizedBox(
      height: height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                          FaIcon(
                            FontAwesomeIcons.question,
                            color: AppColors.textSecondaryColor,
                            size: 50,
                          ),
                          SizedBox(height: 20),
                          Text('Brak danych'),
                        ],
                      ),
                    );
                  }

                  return Obx(
                    () {
                      final allTransactions = snapshot.data!;

                      final allFilteredTransactions =
                          controller.filterTransactions(snapshot.data!);

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                height: height * 0.4,
                                child: buildChart(allFilteredTransactions),
                              ),
                            ),
                            Text('Statystyki w wybranym okresie czasu',
                                style: TextAppTheme.textTheme.titleMedium),
                            const SizedBox(height: 20),
                            buildSummary(
                                allFilteredTransactions, allTransactions),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
