import 'dart:async';

import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/features/authentication/screens/succes_screen/succes_screen.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerifyController extends GetxController {
  static EmailVerifyController get instance => Get.find();

  Timer? _verificationTimer; // Referencja do timera

  @override
  void onInit() {
    sendVerificationEmail();
    setRedirectTimer();
    super.onInit();
  }

  @override
  void onClose() {
    cancelRedirectTimer(); // Anulowanie timera przy usuwaniu kontrolera
    super.onClose();
  }

  void setRedirectTimer() {
    _verificationTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          timer.cancel();
          return;
        }

        await user.reload();

        if (user.emailVerified) {
          timer.cancel();

          if (AuthenticationRepository.instance.authUser?.uid == user.uid) {
            Get.off(const SuccesScreen());
          }
        }
      },
    );
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

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(const SuccesScreen());
    }
  }

  void cancelRedirectTimer() {
    _verificationTimer?.cancel();
    _verificationTimer = null;
  }
}
