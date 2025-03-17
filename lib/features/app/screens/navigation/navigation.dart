import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/navigation/controllers/navigation_controller.dart';
import 'package:enginner_project/features/app/screens/navigation/widgets/custom_drawer_header.dart';
import 'package:enginner_project/features/app/screens/navigation/widgets/invitation_info.dart';
import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_tooltip.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              icon: const FaIcon(
                FontAwesomeIcons.house,
                color: AppColors.textSecondaryColor,
                size: 30,
              ),
              label: Text(
                'Ekran główny',
                style: TextAppTheme.textTheme.bodyLarge,
              ),
            ),
            NavigationDrawerDestination(
              icon: const FaIcon(
                FontAwesomeIcons.creditCard,
                color: AppColors.textSecondaryColor,
                size: 30,
              ),
              label: Text(
                'Karty lojalnościowe',
                style: TextAppTheme.textTheme.bodyLarge,
              ),
            ),
            NavigationDrawerDestination(
              icon: const FaIcon(
                FontAwesomeIcons.crosshairs,
                color: AppColors.textSecondaryColor,
                size: 30,
              ),
              label: Text(
                'Cele oszczędnościowe',
                style: TextAppTheme.textTheme.bodyLarge,
              ),
            ),
            NavigationDrawerDestination(
              icon: const FaIcon(
                FontAwesomeIcons.chartSimple,
                color: AppColors.textSecondaryColor,
                size: 30,
              ),
              label: Text(
                'Statystyki',
                style: TextAppTheme.textTheme.bodyLarge,
              ),
            ),
            NavigationDrawerDestination(
              icon: const FaIcon(
                FontAwesomeIcons.addressBook,
                color: AppColors.textSecondaryColor,
                size: 30,
              ),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Znajomi',
                    style: TextAppTheme.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 0,
                      maxWidth: 36,
                      maxHeight: 36,
                    ),
                    child: CustomTooltip(
                      message: 'Masz nowe zaproszenia do grona znajomych',
                      child: InfoWidget(
                        stream: UserRepository.instance
                            .streamFriendsInvitationsCount(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            NavigationDrawerDestination(
              icon: const FaIcon(
                FontAwesomeIcons.userGroup,
                color: AppColors.textSecondaryColor,
                size: 30,
              ),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Wspólne rachunki',
                    style: TextAppTheme.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 0,
                      maxWidth: 36,
                      maxHeight: 36,
                    ),
                    child: CustomTooltip(
                      message: 'Masz nowe zaproszenia do konta wspólnego',
                      child: InfoWidget(
                        stream: UserRepository.instance
                            .streamSharedAccountInvitationsCount(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.switchScreens(controller.selectedIndex.value),
      ),
    );
  }
}
