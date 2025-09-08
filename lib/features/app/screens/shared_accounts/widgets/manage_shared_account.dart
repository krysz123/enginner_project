import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/controllers/shared_account_manage_controller.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/friends_to_invite_widget.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/members_shared_account_managelist_widget.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ManageSharedAccountScreen extends StatelessWidget {
  const ManageSharedAccountScreen({super.key, required this.sharedAccount});

  final SharedAccountModel sharedAccount;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedAccountManageController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(sharedAccount.title),
        actions: [
          IconButton(
            onPressed: () => CustomDialog.customDialog(
                title: 'Usuń konto wspólne',
                subtitle:
                    'Czy na pewno chcesz usunąć konto wspólne: ${sharedAccount.title}?',
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              text: 'Zamknij',
                              height: 50,
                              width: 30,
                              redirection: () => Get.back(),
                              colorGradient1: AppColors.loginBackgorund1,
                              colorGradient2: AppColors.blueButton),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                              text: 'Usuń',
                              height: 50,
                              width: 30,
                              redirection: () => CustomDialog.customDialog(
                                    title:
                                        'Potwierdź usunięcie konta wspólnego',
                                    subtitle:
                                        'Upewnij się że chcesz usunąć to konto wspólne',
                                    widget: Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                              text: 'Zamknij',
                                              height: 50,
                                              width: 30,
                                              redirection: () {
                                                Get.back();
                                              },
                                              colorGradient1:
                                                  AppColors.loginBackgorund1,
                                              colorGradient2:
                                                  AppColors.blueButton),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: CustomButton(
                                              text: 'Usuń',
                                              height: 50,
                                              width: 30,
                                              redirection: () {
                                                controller.deleteSharedAccount(
                                                    sharedAccount.id);
                                              },
                                              colorGradient1:
                                                  AppColors.redColorGradient,
                                              colorGradient2:
                                                  AppColors.blueButton),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                    icon:
                                        FontAwesomeIcons.arrowRightFromBracket,
                                  ),
                              colorGradient1: AppColors.blueButton,
                              colorGradient2: AppColors.redColorGradient),
                        )
                      ],
                    ),
                  ],
                ),
                icon: FontAwesomeIcons.info),
            icon: const Icon(
              Icons.delete,
              size: 30,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PageView(
                controller: controller.pageViewController,
                onPageChanged: (value) => controller.updatePage(value),
                children: [
                  MembersSharedAccountManageListWidget(
                    sharedAccount: sharedAccount,
                    controller: controller,
                  ),
                  FriendsToInviteWidget(
                    sharedAccount: sharedAccount,
                    controller: controller,
                  ),
                ],
              ),
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
      ),
    );
  }
}
