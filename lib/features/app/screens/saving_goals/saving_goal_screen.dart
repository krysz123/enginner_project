import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/saving_goals/widgets/add_saving_amount_form.dart';
import 'package:enginner_project/features/app/screens/saving_goals/widgets/goal_payments_list.dart';
import 'package:enginner_project/features/app/screens/saving_goals/widgets/saving_goal_form.dart';
import 'package:enginner_project/models/saving_goal_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/popups/custom_tooltip.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SavingGoalsScreen extends StatelessWidget {
  const SavingGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarHeight = DeviceUtility.getAppBarHeight();

    double displayPercent(double current, double goal) {
      double value = current / goal * 100.0;

      double truncatedValue = (value * 100).toInt() / 100.0;

      return truncatedValue;
    }

    double countPercent(double current, double goal) {
      double value = current / goal;
      if (value <= 1.0) {
        return value;
      } else {
        return 1.0;
      }
    }

    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: appBarHeight, right: 30),
            child: IconButton(
              onPressed: () => CustomDialog.customDialog(
                title: 'Dodaj cel oszczędnościowy',
                subtitle: 'Podaj informacje o celu',
                widget: const SavingGoalForm(),
                icon: Icons.attach_money_outlined,
              ),
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<SavingGoalModel>>(
                    stream: UserRepository.instance.streamAllSavingGoals(),
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
                                'Nie masz jeszcze żadnych celów oszczędnościowych',
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
                            child: GestureDetector(
                              onTap: (() => Get.to(() =>
                                  GoalPaymentsList(savingGoal: savingGoal))),
                              onLongPress: () => CustomDialog.customDialog(
                                  title: 'Dodaj kwote',
                                  subtitle: 'Podaj zaoszczędzoną kwotę',
                                  widget: AddSavingAmountForm(
                                    savingGoal: savingGoal,
                                  ),
                                  icon: Icons.add),
                              child: Card(
                                color: AppColors.secondary,
                                shape: savingGoal.currentAmount ==
                                        savingGoal.goal
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: AppColors.greenColorGradient
                                              .withOpacity(0.7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      )
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        savingGoal.title,
                                        style: TextAppTheme
                                            .textTheme.headlineSmall,
                                        textAlign: TextAlign.end,
                                      ),
                                      Text(savingGoal.description),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          CustomTooltip(
                                            message:
                                                'Aktualnie zaoszczędzona kwota',
                                            child: Text(
                                              savingGoal.currentAmount
                                                  .toString(),
                                              style: TextAppTheme
                                                  .textTheme.titleMedium,
                                            ),
                                          ),
                                          const Spacer(),
                                          CustomTooltip(
                                            message: 'Cel oszczędnościowy',
                                            child: Text(
                                              savingGoal.currentAmount
                                                  .toString(),
                                              style: TextAppTheme
                                                  .textTheme.titleMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: LinearPercentIndicator(
                                          animation: true,
                                          lineHeight: 30.0,
                                          animationDuration: 2000,
                                          barRadius: const Radius.circular(30),
                                          percent: countPercent(
                                              savingGoal.currentAmount,
                                              savingGoal.goal),
                                          center: Text(
                                            '${displayPercent(savingGoal.currentAmount, savingGoal.goal)} %',
                                            style: TextAppTheme
                                                .textTheme.titleMedium,
                                          ),
                                          backgroundColor:
                                              AppColors.textSecondaryColor,
                                          linearGradient: const LinearGradient(
                                            colors: [
                                              AppColors.blueButton,
                                              AppColors.greenColorGradient
                                            ],
                                          ),
                                        ),
                                      ),
                                      savingGoal.currentAmount ==
                                              savingGoal.goal
                                          ? Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                  'zakończony!'.toUpperCase(),
                                                  style: TextAppTheme
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                    color: AppColors
                                                        .greenColorGradient,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
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
          ),
        )
      ],
    );
  }
}
