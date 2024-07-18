import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instaance => Get.find();

  final Rx<bool> isShowPasswordEnableLogin = true.obs;

  void changeShowPasswordStatus() {
    isShowPasswordEnableLogin.value = !isShowPasswordEnableLogin.value;
  }
}
