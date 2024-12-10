import 'package:enginner_project/models/debt_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class DebtCardWidget extends StatelessWidget {
  const DebtCardWidget({
    super.key,
    required this.debt,
  });

  final DebtModel debt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: AppColors.secondary,
        shape: debt.status
            ? RoundedRectangleBorder(
                side: const BorderSide(
                    color: AppColors.greenColorGradient, width: 2),
                borderRadius: BorderRadius.circular(20))
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      debt.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextAppTheme.textTheme.titleMedium,
                    ),
                    Text(
                      debt.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            debt.status == false
                                ? AppColors.redColorGradient
                                : AppColors.greenColorGradient,
                            AppColors.onBoarding2
                          ]),
                          border: Border.all(
                            width: 3,
                            color: AppColors.loginBackgorund1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Text(
                            '${debt.amount.toString()} PLN',
                            overflow: TextOverflow.ellipsis,
                            style: TextAppTheme.textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ),
                    debt.status
                        ? Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'oddane!'.toUpperCase(),
                                style: TextAppTheme.textTheme.titleMedium!
                                    .copyWith(
                                  color: AppColors.greenColorGradient,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
