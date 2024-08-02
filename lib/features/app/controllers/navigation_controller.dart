import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/features/app/screens/loyalty_cards/loyalty_cards_screen.dart';
import 'package:enginner_project/features/app/screens/main_screen/main_screen.dart';
import 'package:enginner_project/utils/popups/custom_alert.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SideBarController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  changeDestination(value) {
    selectedIndex.value = value;
    Get.back();
  }

  final screens = [
    const MainScreen(),
    const LoyaltyCardsScreen(),
    // AuthenticationRepository.instance.logout()
  ];
}
