import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/friends/controllers/friends_controller.dart';
import 'package:enginner_project/features/app/screens/friends/widgets/debt_screen.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({
    super.key,
    required this.controller,
  });

  final FriendsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Lista znajomych',
            style: TextAppTheme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Expanded(
              child: StreamBuilder(
            stream: UserRepository.instance.streamFriendsList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Błąd: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.textSecondaryColor,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nie masz jeszcze znajomych',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }

              final allFriends = snapshot.data!;
              return ListView.builder(
                itemCount: allFriends.length,
                itemBuilder: (context, index) {
                  final friend = allFriends[index];

                  return GestureDetector(
                    onLongPress: () {
                      CustomDialog.customDialog(
                          title: 'Znajomy',
                          subtitle: 'Dane znajomego',
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friend.fullname,
                                style: TextAppTheme.textTheme.titleMedium,
                              ),
                              Text(
                                friend.email,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomButton(
                                          text: 'Usuń znajomego',
                                          height: 40,
                                          width: 40,
                                          redirection: () =>
                                              CustomDialog.customDialog(
                                                  title: 'Usuń znajomego',
                                                  subtitle:
                                                      'Czy na pewno chcesz usunąć znajomego?',
                                                  widget: Row(
                                                    children: [
                                                      Expanded(
                                                        child: CustomButton(
                                                            text: 'Zamknij',
                                                            height: 50,
                                                            width: 30,
                                                            redirection: () =>
                                                                Get.back(),
                                                            colorGradient1:
                                                                AppColors
                                                                    .loginBackgorund1,
                                                            colorGradient2:
                                                                AppColors
                                                                    .blueButton),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: CustomButton(
                                                            text: 'Usuń',
                                                            height: 50,
                                                            width: 30,
                                                            redirection: () {
                                                              UserRepository
                                                                  .instance
                                                                  .deleteFriend(
                                                                      friend
                                                                          .id);
                                                              Get.back();
                                                              Get.back();
                                                            },
                                                            colorGradient1:
                                                                AppColors
                                                                    .blueButton,
                                                            colorGradient2:
                                                                AppColors
                                                                    .redColorGradient),
                                                      )
                                                    ],
                                                  ),
                                                  icon:
                                                      FontAwesomeIcons.person),
                                          colorGradient1:
                                              AppColors.redColorGradient,
                                          colorGradient2: AppColors.blueButton))
                                ],
                              )
                            ],
                          ),
                          icon: Icons.people);
                    },
                    child: Card(
                      color: AppColors.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                friend.fullname,
                                overflow: TextOverflow.ellipsis,
                                style: TextAppTheme.textTheme.titleMedium,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(
                                () => DebtScreen(friend: friend),
                              ),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      AppColors.greenColorGradient,
                                      AppColors.blueButton
                                    ])),
                                child: const Icon(
                                  Icons.attach_money_rounded,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
