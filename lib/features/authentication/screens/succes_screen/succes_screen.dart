import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class SuccesScreen extends StatelessWidget {
  const SuccesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight();
    final width = DeviceUtility.getScreenWidth(context);
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.loginBackgorund1.withOpacity(0.4),
              AppColors.loginBackgorund1,
              AppColors.loginBackgorund2,
              AppColors.loginBackgorund3,
              AppColors.loginBackgorund4,
              AppColors.loginBackgorund5,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.lg, vertical: Sizes.xxl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: height * 0.05),
                Image(
                  image: const AssetImage(
                    'assets/images/succes/succes.gif',
                  ),
                  height: height * 0.4,
                ),
                Text(
                  'Udało się!',
                  style: TextAppTheme.textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Twoje konto zostało utworzone. Kliknij kontunuuj aby przejść do ekranu głównego! ',
                  style: TextAppTheme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.15),
                CustomButton(
                  text: 'Kontynuj',
                  height: height * 0.08,
                  width: width,
                  redirection: () =>
                      AuthenticationRepository.instance.redirectScreen(),
                  colorGradient1: AppColors.greenColorGradient,
                  colorGradient2: AppColors.blueButton,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
