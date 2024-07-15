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
}
