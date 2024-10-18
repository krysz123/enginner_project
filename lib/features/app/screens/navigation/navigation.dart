import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/features/app/screens/navigation/controllers/navigation_controller.dart';
import 'package:enginner_project/features/app/screens/navigation/widgets/custom_drawer_header.dart';
import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SideBarController());
    final userController = Get.put(UserController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
      ),
      drawer: Obx(
        () => NavigationDrawer(
          indicatorColor: Colors.transparent,
          backgroundColor: AppColors.primary,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) => controller.changeDestination(value),
          children: [
            CustomDrawerHeader(controller: userController),
            NavigationDrawerDestination(
                icon: const Icon(Icons.house, size: 35),
                label: Text('Ekran główny',
                    style: TextAppTheme.textTheme.bodyLarge)),
            NavigationDrawerDestination(
                icon: const Icon(Icons.credit_card_sharp, size: 35),
                label: Text('Karty lojalnościowe',
                    style: TextAppTheme.textTheme.bodyLarge)),
            NavigationDrawerDestination(
                icon: const Icon(Icons.monetization_on_outlined, size: 35),
                label: Text('Cele oszczędnościowe',
                    style: TextAppTheme.textTheme.bodyLarge)),
            NavigationDrawerDestination(
                icon: const Icon(Icons.analytics_outlined, size: 35),
                label: Text('Statystyki',
                    style: TextAppTheme.textTheme.bodyLarge)),
            NavigationDrawerDestination(
                icon: const Icon(Icons.person, size: 35),
                label:
                    Text('Znajomi', style: TextAppTheme.textTheme.bodyLarge)),
            NavigationDrawerDestination(
                icon: const Icon(Icons.people, size: 35),
                label: Text('Wspólne rachunki',
                    style: TextAppTheme.textTheme.bodyLarge)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1),
            ),
            TextButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              child: Text(
                'Wyloguj',
                style: TextAppTheme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      body: Obx(
        () => controller.switchScreens(controller.selectedIndex.value),
      ),
    );
  }
}
