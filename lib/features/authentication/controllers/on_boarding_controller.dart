import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

class OnBoardingController extends GetxController {
  final liquidController = LiquidController();
  Rx<int> currentPage = 0.obs;

  void skipPage() {
    currentPage.value = 2;
    liquidController.jumpToPage(page: 2);
  }

  void updatePage(int index) => currentPage.value = index;
}
