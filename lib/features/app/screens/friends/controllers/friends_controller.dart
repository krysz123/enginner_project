import 'package:enginner_project/enums/friend_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsController extends GetxController {
  static FriendsController get instance => Get.find();

  final values = RxList<bool>([true, false, false]);
  final status = FriendStatusEnum.sendInvite.label.obs;
  final values2 = [
    FriendStatusEnum.sendInvite.label,
    FriendStatusEnum.invitation.label,
    FriendStatusEnum.rejected.label
  ].obs;

  Rx<int> currentPage = 0.obs;
  final pageViewController = PageController();

  void updatePage(int index) => currentPage.value = index;

  void switchValues(int index) {
    for (var i = 0; i < values.length; i++) {
      values[i] = false;
    }
    values[index] = true;
    status.value = values2[index];
  }
}
