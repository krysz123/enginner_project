import 'package:enginner_project/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:enginner_project/features/authentication/screens/signup/signup.dart';
import 'package:enginner_project/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App({super.key, this.onboarding = false});

  final bool onboarding;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      title: 'WalletWatch',
      home: onboarding ? const SignupScreen() : const OnBoardingScreen(),
    );
  }
}
