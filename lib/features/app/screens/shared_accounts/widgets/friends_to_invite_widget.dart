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

class FriendsToInviteWidget extends StatelessWidget {
  const FriendsToInviteWidget({
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
          'Zaproś',
          style: TextAppTheme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: StreamBuilder<List<Map<String, String>>>(
            stream: UserRepository.instance
                .streamUsersNotInSharedAccount(sharedAccount.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Błąd: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Nie odnaleziono znajomych');
              }

              final friends = snapshot.data!;
              return ListView.builder(
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
                              '${friend['Fullname']}',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 3,
                              style: TextAppTheme.textTheme.titleMedium,
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.blueButton,
                                    AppColors.greenColorGradient
                                  ],
                                ),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.plus,
                                size: 20,
                              ),
                            ),
                            onTap: () => CustomDialog.customDialog(
                                title: 'Wyślij zaproszenie',
                                subtitle:
                                    'Chcesz zaprosić użytkownika ${friend['Fullname']} do wspólnego rachunku ${sharedAccount.title}?',
                                widget: Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                          text: 'Cofnij',
                                          height: 50,
                                          width: 30,
                                          redirection: () => Get.back(),
                                          colorGradient1: AppColors.blueButton,
                                          colorGradient2:
                                              AppColors.redColorGradient),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomButton(
                                          text: 'Zaproś',
                                          height: 50,
                                          width: 30,
                                          redirection: () => controller
                                              .sendInviteToSharedAccount(
                                                  sharedAccount.id,
                                                  '${friend['id']}'),
                                          colorGradient1: AppColors.blueButton,
                                          colorGradient2:
                                              AppColors.greenColorGradient),
                                    )
                                  ],
                                ),
                                icon: Icons.person_add_alt_1),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
