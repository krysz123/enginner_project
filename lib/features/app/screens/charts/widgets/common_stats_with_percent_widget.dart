import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_tooltip.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CommonStatsWithPercentWidget extends StatelessWidget {
  const CommonStatsWithPercentWidget({
    super.key,
    required this.filteredValues,
    required this.allValues,
    required this.title,
    required this.mark,
    required this.percent,
  });

  final dynamic filteredValues;
  final dynamic allValues;
  final String title;
  final String mark;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: AppColors.secondary,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextAppTheme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CustomTooltip(
                        message: 'Wartość z wybranego okresu czasu',
                        child: Text(
                          '$filteredValues $mark',
                          style: TextAppTheme.textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      CustomTooltip(
                        message: 'Wartość ogólna',
                        child: Text(
                          '$allValues $mark',
                          style: TextAppTheme.textTheme.titleSmall,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearPercentIndicator(
                    animation: true,
                    lineHeight: 10.0,
                    animateFromLastPercent: true,
                    animationDuration: 500,
                    barRadius: const Radius.circular(30),
                    percent: percent,
                    backgroundColor: AppColors.textSecondaryColor,
                    linearGradient: const LinearGradient(
                      colors: [
                        AppColors.blueButton,
                        AppColors.greenColorGradient
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
