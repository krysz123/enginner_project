import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instaance => Get.find();

  final Rx<bool> isShowPasswordEnable = true.obs;
  final Rx<bool> isShowRepeatPasswordEnable = true.obs;

  void changeShowPasswordStatus() {
    isShowPasswordEnable.value = !isShowPasswordEnable.value;
  }

  void changeShowRepeatPasswordStatus() {
    isShowRepeatPasswordEnable.value = !isShowRepeatPasswordEnable.value;
  }

  // -- SIGNUP

  final emial = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
}
