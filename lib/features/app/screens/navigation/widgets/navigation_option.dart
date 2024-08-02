import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class NavigationOption extends StatelessWidget {
  const NavigationOption({
    super.key,
    required this.icon,
    required this.text,
    // required this.redirection,
  });

  final IconData icon;
  final String text;
  // final VoidCallback redirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.xs,
        horizontal: Sizes.sm,
      ),
      child: ListTile(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Icon(
                (icon),
                size: 30,
                color: AppColors.textSecondaryColor,
              ),
              const SizedBox(width: 20),
              Text(
                text,
                style: TextAppTheme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        // onTap: redirection,
      ),
    );
  }
}
