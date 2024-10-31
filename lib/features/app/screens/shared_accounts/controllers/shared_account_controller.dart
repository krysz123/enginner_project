import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedAccountController extends GetxController {
  static SharedAccountController get instance => Get.find();
  final userRepository = UserRepository.instance;
  var sharedAccountInvitations = <SharedAccountModel>[].obs;

  @override
  void onInit() {
    sharedAccountInvitations
        .bindStream(userRepository.streamSharedAccountInvitations());
    super.onInit();
  }

  Rx<int> currentPage = 0.obs;
  final pageViewController = PageController();

  void updatePage(int index) => currentPage.value = index;
}
