import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isObscureText = false,
    this.obscureCharacter = "•",
    this.suffixIcon,
    // required this.controller,
  });

  final String hintText;
  // final TextEditingController controller;
  final bool isObscureText;
  final String? obscureCharacter;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtility.getScreenWidth(context);
    final height = DeviceUtility.getScreenHeight();
    return TextFormField(
      // controller: controller,
      obscureText: isObscureText,
      obscuringCharacter: obscureCharacter!,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        constraints: BoxConstraints(
          maxHeight: height * 0.075,
          maxWidth: width,
        ),
        contentPadding: const EdgeInsets.fromLTRB(15, 25, 25, 10),
        filled: true,
        fillColor: AppColors.primary,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
