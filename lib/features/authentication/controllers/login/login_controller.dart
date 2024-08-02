import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/utils/device/network_connection.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final Rx<bool> isShowPasswordEnableLogin = true.obs;

  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void changeShowPasswordStatus() {
    isShowPasswordEnableLogin.value = !isShowPasswordEnableLogin.value;
  }

  void signIn() async {
    try {
      //VALIDATION
      if (!loginFormKey.currentState!.validate()) {
        return;
      }
      //INTERNET
      final isConnected = await NetworkConnection.instance.isConnected();
      if (!isConnected) {
        throw 'Brak połączenia z internetem';
      }
      //LOADER
      Get.to(() => const FullScreenLoader());

      //! SHARED PREFERENCES FOR REMEMBER USER
      // final shprf = await SharedPreferences.getInstance();
      // shprf.setString('EMAIL', email.text.trim());
      // shprf.setString('PASSWORD', password.text.trim());

      //LOGIN
      final userCredentials = await AuthenticationRepository.instance
          .login(email.text.trim(), password.text.trim());

      FullScreenLoader.stopLoading();

      AuthenticationRepository.instance.redirectScreen();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
