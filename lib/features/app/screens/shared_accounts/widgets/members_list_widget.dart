import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/controllers/shared_account_manage_controller.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MembersListWidget extends StatelessWidget {
  const MembersListWidget({
    super.key,
    required this.sharedAccount,
    required this.controller,
  });

  final SharedAccountModel sharedAccount;
  final SharedAccountManageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Członkowie',
          style: TextAppTheme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),
        StreamBuilder<List<Map<String, String>>>(
          stream: UserRepository.instance
              .streamUsersToSharedAccount(sharedAccount.id, true),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Błąd: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Nie odnaleziono znajomych');
            }

            final friends = snapshot.data!;
            return Expanded(
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return Card(
                    color: AppColors.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${friend['FirstName']} ${friend['LastName']}',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 3,
                              style: TextAppTheme.textTheme.titleMedium,
                            ),
                          ),
                          !(sharedAccount.owner == '${friend['Email']}')
                              ? InkWell(
                                  splashColor: Colors.transparent,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.blueButton,
                                          AppColors.redColorGradient
                                        ],
                                      ),
                                    ),
                                    child: const Icon(
                                      FontAwesomeIcons.minus,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () => CustomDialog.customDialog(
                                      title: 'Wyślij zaproszenie',
                                      subtitle: 'Czy chcesz wysłać zaproszenie',
                                      widget: Row(
                                        children: [
                                          Expanded(
                                            child: CustomButton(
                                                text: 'Cofnij',
                                                height: 50,
                                                width: 30,
                                                redirection: () => Get.back(),
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
                                                redirection: () => controller
                                                    .removeUserFromSharedAccount(
                                                        sharedAccount.id,
                                                        '${friend['id']}'),
                                                colorGradient1:
                                                    AppColors.blueButton,
                                                colorGradient2:
                                                    AppColors.redColorGradient),
                                          )
                                        ],
                                      ),
                                      icon: FontAwesomeIcons.userPlus),
                                )
                              : const Text(' - ja'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
