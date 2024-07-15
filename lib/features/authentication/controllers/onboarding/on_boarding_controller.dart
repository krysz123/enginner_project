import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final liquidController = LiquidController();
  Rx<int> currentPage = 0.obs;

  void skipPage() {
    currentPage.value = 2;
    liquidController.jumpToPage(page: 2);
  }

  void updatePage(int index) => currentPage.value = index;
}
