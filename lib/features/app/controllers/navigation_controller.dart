import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/features/app/screens/loyalty_cards/loyalty_cards_screen.dart';
import 'package:enginner_project/features/app/screens/main_screen/main_screen.dart';
import 'package:enginner_project/utils/popups/custom_alert.dart';
import 'package:get/get.dart';

class SideBarController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  changeDestination(value) {
    selectedIndex.value = value;
    Get.back();
  }

  switchScreens(index) {
    switch (index) {
      case 0:
        return const MainScreen();
      case 1:
        return const LoyaltyCardsScreen();
      default:
        return const MainScreen();
    }
  }

  // final screens = [
  //   const MainScreen(),
  //   const LoyaltyCardsScreen(),
  //   // AuthenticationRepository.instance.logout()
  // ];
}
