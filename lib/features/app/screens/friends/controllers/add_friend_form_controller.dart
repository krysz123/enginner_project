import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/utils/device/network_connection.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendFormController extends GetxController {
  static AddFriendFormController get instance => Get.find();
  final controller = UserRepository.instance;

  final email = TextEditingController();

  GlobalKey<FormState> addFriendFormKey = GlobalKey<FormState>();

  void addFriend() async {
    try {
      if (!addFriendFormKey.currentState!.validate()) {
        return;
      }

      final isConnected = await NetworkConnection.instance.isConnected();
      if (!isConnected) {
        throw 'Brak połączenia z internetem';
      }

      final ifEmailExist =
          await UserRepository.instance.checkIfEmailExist(email.text);
      if (!ifEmailExist) {
        email.clear(); //??
        throw 'Podany adres email nie został odnaleziony';
      }

      if (AuthenticationRepository.instance.authUser?.email == email.text) {
        throw 'Podany adres e-mail należy do Ciebie';
      }

      await controller.sendInvite(email.text);
      Get.back();
      Snackbars.succesSnackbar(
          title: 'Udało się!',
          message: 'Wysłano zaproszenie do użytkownika ${email.text}');
    } catch (e) {
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
