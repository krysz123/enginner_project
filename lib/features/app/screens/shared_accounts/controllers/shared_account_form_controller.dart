import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/device/network_connection.dart';
import 'package:enginner_project/utils/popups/full_screen_loader.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SharedAccountFormController extends GetxController {
  static SharedAccountFormController get instance => Get.find();

  GlobalKey<FormState> sharedAccountFormKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final members = <String, dynamic>{}.obs;
  final controller = UserRepository.instance;

  void addToMembers(String memberId) {
    members[memberId] = false;
  }

  void deleteFromMembers(String memberId) {
    members.remove(memberId);
  }

  bool checkIsKeyInMap(Map<String, dynamic> map, String memmberId) {
    return map.containsKey(memmberId);
  }

  void createNewSharedAccount() async {
    var uuid = const Uuid();
    String savingNewSharedAccountId = uuid.v4();
    try {
      if (!sharedAccountFormKey.currentState!.validate()) {
        return;
      }
      final isConnected = await NetworkConnection.instance.isConnected();
      if (!isConnected) {
        throw 'Brak połączenia z internetem';
      }
      Get.to(() => const FullScreenLoader());

      members[AuthenticationRepository.instance.authUser!.uid] = true;

      final newSharedAccount = SharedAccountModel(
        id: savingNewSharedAccountId,
        title: title.text,
        currentBalance: 0,
        owner: AuthenticationRepository.instance.authUser!.email!,
        members: members,
      );

      await controller.storeNewSharedAccount(newSharedAccount);

      FullScreenLoader.stopLoading();
      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Snackbars.errorSnackbar(title: 'Błąd!', message: e.toString());
    }
  }
}
