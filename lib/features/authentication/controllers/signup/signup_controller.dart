import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/authentication/screens/email_verify/email_verify.dart';
import 'package:enginner_project/models/user_model.dart';
import 'package:enginner_project/utils/device/network_connection.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final Rx<bool> isShowPasswordEnable = true.obs;

  void changeShowPasswordStatus() {
    isShowPasswordEnable.value = !isShowPasswordEnable.value;
  }

  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      Get.to(() => const FullScreenLoader());

      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      final isConnected = await NetworkConnection.instance.isConnected();
      if (!isConnected) {
        throw 'Brak połączenia z internetem';
      }

      final userCredentials = await AuthenticationRepository.instance
          .register(email.text.trim(), password.text.trim());

      final newUser = UserModel(
        id: userCredentials.user!.uid,
        email: email.text.trim(),
        firstname: firstName.text.trim(),
        lastname: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        totalBalance: 0.0,
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      FullScreenLoader.stopLoading();

      Get.offAll(() => EmailVerificationScreen(email: email.text.trim()));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
