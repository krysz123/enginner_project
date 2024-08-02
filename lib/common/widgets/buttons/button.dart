import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.height,
    required this.width,
    required this.redirection,
    required this.colorGradient1,
    required this.colorGradient2,
  });

  final String text;
  final double height;
  final double width;
  final VoidCallback redirection;
  final Color colorGradient1;
  final Color colorGradient2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: redirection,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorGradient1, colorGradient2],
          ),
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            text,
            style: TextAppTheme.textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
