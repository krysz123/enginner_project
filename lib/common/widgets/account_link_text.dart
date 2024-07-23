import 'package:enginner_project/features/authentication/screens/login/login.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountLinkText extends StatelessWidget {
  const AccountLinkText({
    super.key,
    required this.text,
    required this.textLink,
    required this.redirection,
  });

  final String text;
  final String textLink;
  final VoidCallback redirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextAppTheme.textTheme.bodyMedium,
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: redirection,
          child: Text(
            textLink,
            style: TextAppTheme.textTheme.bodyMedium!.copyWith(
              color: AppColors.deleteExpenseColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
