import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/members_shared_account_widget.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LeaveSharedAccountButtonWidget extends StatelessWidget {
  const LeaveSharedAccountButtonWidget({
    super.key,
    required this.sharedAccount,
  });

  final SharedAccountModel sharedAccount;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => CustomDialog.customDialog(
          title: 'Konto wspólne: ${sharedAccount.title}',
          subtitle: 'Lista członków',
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: MembersSharedAccountWidget(
                  sharedAccount: sharedAccount,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(height: 1, color: AppColors.textSecondaryColor),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Opuść konto wspólne',
                          style: TextAppTheme.textTheme.titleLarge,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          'Czy na pewno chcesz opuścić konto wspólne: ${sharedAccount.title}?',
                          style: TextAppTheme.textTheme.labelMedium,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
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
                        text: 'Opuść',
                        height: 50,
                        width: 30,
                        redirection: () => CustomDialog.customDialog(
                              title: 'Potwierdź opuszczenie konta wspólnego',
                              subtitle:
                                  'Upewnij się że chcesz opuścić to konto wspólne',
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
                                        colorGradient2: AppColors.blueButton),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomButton(
                                        text: 'Opuść',
                                        height: 50,
                                        width: 30,
                                        redirection: () {
                                          UserRepository.instance
                                              .rejectInviteToSharedAccount(
                                                  AuthenticationRepository
                                                      .instance.authUser!.uid,
                                                  sharedAccount.id);
                                          Get.back();
                                          Get.back();
                                          Get.back();
                                        },
                                        colorGradient1:
                                            AppColors.redColorGradient,
                                        colorGradient2: AppColors.blueButton),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              icon: FontAwesomeIcons.arrowRightFromBracket,
                            ),
                        colorGradient1: AppColors.blueButton,
                        colorGradient2: AppColors.redColorGradient),
                  )
                ],
              ),
            ],
          ),
          icon: FontAwesomeIcons.info),
      icon: const Icon(FontAwesomeIcons.info),
    );
  }
}
