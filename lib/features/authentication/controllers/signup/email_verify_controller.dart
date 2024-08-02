import 'dart:async';

import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/features/authentication/screens/succes_screen/succes_screen.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerifyController extends GetxController {
  static EmailVerifyController get instance => Get.find();

  @override
  void onInit() {
    sendVerificationEmail();
    setRedirectTimer();
    super.onInit();
  }

  sendVerificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendVerificationEmail();
      Snackbars.succesSnackbar(
          title: 'Potwierdź swój adres email!',
          message: 'Na podany adres email został wysłany link do weryfikacji.');
    } catch (e) {
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }

  setRedirectTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(const SuccesScreen());
        }
      },
    );
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(const SuccesScreen());
    }
  }
}
