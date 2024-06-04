import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Lato',
    brightness: Brightness.dark,
    primaryColor: AppColors.secondary,
    textTheme: TextAppTheme.textTheme,
  );
}
