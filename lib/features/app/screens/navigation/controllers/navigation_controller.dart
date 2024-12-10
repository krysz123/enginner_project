import 'package:enginner_project/features/app/screens/charts/charts_screen.dart';
import 'package:enginner_project/features/app/screens/friends/friends_screen.dart';
import 'package:enginner_project/features/app/screens/loyalty_cards/loyalty_cards_screen.dart';
import 'package:enginner_project/features/app/screens/main_screen/main_screen.dart';
import 'package:enginner_project/features/app/screens/saving_goals/saving_goal_screen.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/shared_accounts_screen.dart';
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
      case 2:
        return const SavingGoalsScreen();
      case 3:
        return const ChartsScreen();
      case 4:
        return const FriendsScreen();
      case 5:
        return const SharedAccountsScreen();
      default:
        return const MainScreen();
    }
  }
}
