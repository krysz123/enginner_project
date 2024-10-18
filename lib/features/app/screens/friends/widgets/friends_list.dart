import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/friends/controllers/friends_controller.dart';
import 'package:enginner_project/features/app/screens/friends/widgets/debt_screen.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({
    super.key,
    required this.controller,
  });

  final FriendsController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Lista znajmych',
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
                                Text(friend.status)
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
                              // const SizedBox(width: 10),
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: Container(
                              //     width: 40,
                              //     height: 40,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       color: AppColors.blueButton,
                              //     ),
                              //     child: const Icon(Icons.room),
                              //   ),
                              // ),
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
        )),
      ),
    );
  }
}
