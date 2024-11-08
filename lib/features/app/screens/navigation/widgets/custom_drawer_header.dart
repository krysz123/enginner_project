import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key, required this.controller});

  final UserController controller;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: AppColors.secondary,
      ),
      child: Column(
        children: [
          const CircleAvatar(
              radius: 40,
              child: FaIcon(
                FontAwesomeIcons.userLarge,
                size: 30,
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.sm,
            ),
            child: Obx(
              () => Text(
                controller.user.value.fullname,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
