import 'package:enginner_project/features/app/screens/shared_accounts/controllers/shared_account_controller.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_account_form.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_account_invitations.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_accounts_list.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SharedAccountsScreen extends StatelessWidget {
  const SharedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarHeight = DeviceUtility.getAppBarHeight();
    final controller = Get.put(SharedAccountController());
    controller.currentPage.value = 0;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: appBarHeight, right: 30),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () => CustomDialog.customDialog(
                  title: 'Nowy rachunek wspólny',
                  subtitle: 'Dodaj znajomych do wspólnego rachunku',
                  widget: const SharedAccountForm(),
                  icon: Icons.people),
            ),
          ),
        ),
        SafeArea(
          child: PageView(
            controller: controller.pageViewController,
            onPageChanged: (index) => controller.updatePage(index),
            children: const [
              SharedAccountsList(),
              SharedAccountInvitations(),
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
