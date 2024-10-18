import 'package:enginner_project/features/app/screens/friends/controllers/friends_controller.dart';
import 'package:enginner_project/features/app/screens/friends/widgets/friends_form.dart';
import 'package:enginner_project/features/app/screens/friends/widgets/friends_list.dart';
import 'package:enginner_project/features/app/screens/friends/widgets/invitations_screen.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarHeight = DeviceUtility.getAppBarHeight();

    final controller = Get.put(FriendsController());
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: appBarHeight, right: 30),
            child: IconButton(
              onPressed: () => CustomDialog.customDialog(
                  title: 'Dodaj znjomego',
                  subtitle:
                      'Wpisz adres e-mail znajmego aby wysłać zaproszenie',
                  widget: const FriendsForm(),
                  icon: Icons.person),
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ),
        SafeArea(
          child: PageView(
            controller: controller.pageViewController,
            onPageChanged: (index) => controller.updatePage(index),
            children: [
              FriendsList(controller: controller),
              InvitationsScreen(controller: controller),
            ],
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage.value,
                count: 2,
                effect: const WormEffect(
                  activeDotColor: AppColors.greenColorGradient,
                  dotHeight: 5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
