import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/saving_goals/widgets/add_saving_amount_form.dart';
import 'package:enginner_project/models/saving_goal_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalPaymentsList extends StatelessWidget {
  const GoalPaymentsList({super.key, required this.savingGoal});

  final SavingGoalModel savingGoal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(savingGoal.title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lista wpłat',
              style: TextAppTheme.textTheme.titleMedium,
            ),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream:
                    UserRepository.instance.streamGoalPayments(savingGoal.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Błąd: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_money_outlined,
                            color: AppColors.textSecondaryColor,
                            size: 50,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Nie masz jeszcze żadnych wpłat dla tego celu oszczędnościowego',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }

                  final allSavingGoals = snapshot.data!;

                  return ListView.builder(
                    itemCount: allSavingGoals.length,
                    itemBuilder: (context, index) {
                      final savingGoal = allSavingGoals[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Card(
                          color: AppColors.secondary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${savingGoal["Amount"]} PLN',
                                  style: TextAppTheme.textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                ),
                                Text(
                                  '${savingGoal["Date"]}',
                                  style: TextAppTheme.textTheme.labelMedium,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
