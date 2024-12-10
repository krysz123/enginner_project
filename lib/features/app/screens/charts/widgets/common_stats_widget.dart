import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class CommonStatsWidget extends StatelessWidget {
  const CommonStatsWidget({
    super.key,
    required this.filteredValues,
    required this.allValues,
    required this.title,
    required this.mark,
    required this.value,
  });

  final dynamic filteredValues;
  final dynamic allValues;
  final String title;
  final String mark;
  final String value;

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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$title - ',
                          style: TextAppTheme.textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '$value $mark',
                          style: TextAppTheme.textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
