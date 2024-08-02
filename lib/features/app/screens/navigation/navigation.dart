import 'package:enginner_project/features/app/controllers/navigation_controller.dart';
import 'package:enginner_project/features/app/screens/navigation/widgets/custom_drawer_header.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SideBarController());
    final height = DeviceUtility.getScreenHeight();
    final width = DeviceUtility.getScreenWidth(context);
    final appBarHeight = DeviceUtility.getAppBarHeight();

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: Obx(
          () => NavigationDrawer(
            indicatorColor: Colors.transparent,
            backgroundColor: AppColors.primary,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (value) =>
                controller.changeDestination(value),
            children: [
              const CustomDrawerHeader(),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.house, size: 35),
                  label: Text('Ekran główny',
                      style: TextAppTheme.textTheme.bodyLarge)),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.credit_card_sharp, size: 35),
                  label: Text('Karty lojalnościowe',
                      style: TextAppTheme.textTheme.bodyLarge)),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.analytics_outlined, size: 35),
                  label:
                      Text('Wykresy', style: TextAppTheme.textTheme.bodyLarge)),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.monetization_on_outlined, size: 35),
                  label: Text('Cele oszczędnościowe',
                      style: TextAppTheme.textTheme.bodyLarge)),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.person_add_alt, size: 35),
                  label: Text('Profil łączony',
                      style: TextAppTheme.textTheme.bodyLarge)),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.credit_card_sharp, size: 35),
                  label: Text('Rozliczenia',
                      style: TextAppTheme.textTheme.bodyLarge)),
              NavigationDrawerDestination(
                  icon: const Icon(Icons.blinds_closed_outlined, size: 35),
                  label: Text('Karty lojalnościowe',
                      style: TextAppTheme.textTheme.bodyLarge)),
              const Divider(
                height: 1,
              ),
              NavigationDrawerDestination(
                icon: const Icon(Icons.logout, size: 35),
                label: Text('Wyloguj sie',
                    style: TextAppTheme.textTheme.bodyLarge),
              ),
            ],
          ),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
      ),
    );
  }
}
