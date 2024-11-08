import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/utils/device/network_connection.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedAccountManageController extends GetxController {
  static SharedAccountManageController get instance => Get.find();

  Rx<int> currentPage = 0.obs;
  final pageViewController = PageController();

  void updatePage(int index) => currentPage.value = index;

  void sendInviteToSharedAccount(
      String sharedAccountId, String memberId) async {
    try {
      UserRepository.instance.inviteToSharedAccount(sharedAccountId, memberId);
      Get.back();
      Snackbars.succesSnackbar(
          title: 'Udało się!', message: 'Zaproszenie zostało wysłane');
    } catch (e) {
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }

  void removeUserFromSharedAccount(
      String sharedAccountId, String memberId) async {
    try {
      UserRepository.instance.inviteToSharedAccount(sharedAccountId, memberId);
      Get.back();
      Snackbars.infoSnackbar(
          title: 'Udało się!', message: 'Użytkownik został usunięty');
    } catch (e) {
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
