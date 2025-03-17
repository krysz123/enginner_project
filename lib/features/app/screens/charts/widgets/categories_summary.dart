import 'package:enginner_project/enums/all_categories.dart';
import 'package:enginner_project/enums/expense_category_enum.dart';
import 'package:enginner_project/enums/income_category_enum.dart';
import 'package:enginner_project/features/app/screens/charts/controllers/categories_summary_controller.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_tooltip.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CategoriesSummaryWidget extends StatelessWidget {
  const CategoriesSummaryWidget({super.key, required this.transactions});

  final Stream<List<ExpenseModel>> transactions;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesSummaryController());

    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<ExpenseModel>>(
            stream: transactions,
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

              final expenses = snapshot.data!;
              controller.countCategories(expenses);

              return Obx(() {
                // Pobierz wszystkie dane z kontrolera
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
                    children: [
                      Text(
                        'Przychody',
                        style: TextAppTheme.textTheme.titleMedium,
                      ),
                      ...controller.incomesCount.entries.map((entry) {
                        String category = entry.key;
                        int count = entry.value;
                        double sum = controller.incomesSum[category] ?? 0.0;
                        IconData categoryIcon =
                            IncomeCategory.returnIcon(category);

                        return Card(
                          color: AppColors.secondary,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: ListTile(
                            leading: FaIcon(categoryIcon, color: Colors.blue),
                            title: Text(category),
                            subtitle: Text('Suma: $sum PLN'),
                            trailing: CustomTooltip(
                              message: 'Ilość transakcji',
                              child: Text(
                                '$count',
                                style: TextAppTheme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Text(
                        'Wydatki',
                        style: TextAppTheme.textTheme.titleMedium,
                      ),
                      ...controller.expensesCount.entries.map((entry) {
                        String category = entry.key;
                        int count = entry.value;
                        double sum = controller.expensesSum[category] ?? 0.0;
                        IconData categoryIcon =
                            ExpenseCategory.returnIcon(category);

                        return Card(
                          color: AppColors.secondary,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: ListTile(
                            leading: FaIcon(categoryIcon, color: Colors.red),
                            title: Text(category),
                            subtitle: Text('Suma: $sum PLN'),
                            trailing: CustomTooltip(
                              message: 'Ilość transakcji',
                              child: Text(
                                '$count',
                                style: TextAppTheme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Text(
                        'Transakcje gotówkowe',
                        style: TextAppTheme.textTheme.titleMedium,
                      ),
                      ...controller.cashCount.entries.map((entry) {
                        String category = entry.key;
                        int count = entry.value;
                        double sum = controller.cashSum[category] ?? 0.0;
                        IconData categoryIcon =
                            AllCategories.returnIcon(category);

                        return Card(
                          color: AppColors.secondary,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: ListTile(
                            leading: FaIcon(categoryIcon, color: Colors.green),
                            title: Text(category),
                            subtitle: Text('Suma: $sum PLN'),
                            trailing: CustomTooltip(
                              message: 'Ilość transakcji',
                              child: Text(
                                '$count',
                                style: TextAppTheme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Text(
                        'Transkacje kartą',
                        style: TextAppTheme.textTheme.titleMedium,
                      ),
                      ...controller.cardCount.entries.map((entry) {
                        String category = entry.key;
                        int count = entry.value;
                        double sum = controller.cardSum[category] ?? 0.0;

                        IconData categoryIcon =
                            AllCategories.returnIcon(category);

                        return Card(
                          color: AppColors.secondary,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: ListTile(
                            leading: FaIcon(categoryIcon, color: Colors.orange),
                            title: Text(category),
                            subtitle: Text('Suma: $sum PLN'),
                            trailing: CustomTooltip(
                              message: 'Ilość transakcji',
                              child: Text(
                                '$count',
                                style: TextAppTheme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
