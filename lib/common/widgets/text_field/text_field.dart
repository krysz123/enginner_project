// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.obscureCharacter = "•",
    this.suffixIcon,
    this.validator,
    this.isReadOnly = false,
    this.function,
    this.keyboardType = TextInputType.text,
  });

  final String? hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final String? obscureCharacter;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isReadOnly;
  final VoidCallback? function;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtility.getScreenWidth(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.xs),
      child: TextFormField(
        onTap: function,
        controller: controller,
        expands: false,
        validator: validator,
        keyboardType: keyboardType,
        readOnly: isReadOnly,
        obscureText: isObscureText,
        obscuringCharacter: obscureCharacter!,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          constraints: BoxConstraints(
            // maxHeight: height * 0.075,
            maxWidth: width,
            // minHeight: height,
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 25, 25, 10),
          filled: true,
          errorMaxLines: 5,
          fillColor: AppColors.primary,
          hintText: hintText,
          hintStyle: TextAppTheme.textTheme.bodySmall,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
