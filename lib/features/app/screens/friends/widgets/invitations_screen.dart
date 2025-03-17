import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/friend_status_enum.dart';
import 'package:enginner_project/features/app/screens/friends/controllers/friends_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class InvitationsScreen extends StatelessWidget {
  const InvitationsScreen({super.key, required this.controller});

  final FriendsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Zaproszenia',
            style: TextAppTheme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Obx(() {
            return ToggleButtons(
              isSelected: controller.values.toList(),
              constraints: const BoxConstraints(minHeight: 50, minWidth: 100),
              borderRadius: BorderRadius.circular(30),
              onPressed: (index) => controller.switchValues(index),
              selectedColor: AppColors.greenColorGradient,
              textStyle: TextAppTheme.textTheme.labelSmall,
              children: const [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Wysłane'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Otrzymane'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Odrzucone'),
                )
              ],
            );
          }),
          const SizedBox(height: 20),
          Expanded(
              child: StreamBuilder(
            stream: UserRepository.instance.streamInvitations(),
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
                        Icons.message_rounded,
                        color: AppColors.textSecondaryColor,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nie masz jeszcze żadnych zaproszeń',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }

              final invitations = snapshot.data!;
              return ListView.builder(
                itemCount: invitations.length,
                itemBuilder: (context, index) {
                  final invite = invitations[index];

                  return GestureDetector(
                    onLongPress: () {
                      CustomDialog.customDialog(
                          title: 'Zaproszenie',
                          subtitle: 'Dane zaproszenia',
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                invite.fullname,
                                style: TextAppTheme.textTheme.titleMedium,
                              ),
                              Text(
                                invite.email,
                              ),
                              Text(invite.status)
                            ],
                          ),
                          icon: Icons.people);
                    },
                    child: Obx(
                      () => controller.status.value == invite.status
                          ? Card(
                              color: AppColors.secondary,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              invite.fullname,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextAppTheme
                                                  .textTheme.titleMedium,
                                            ),
                                            Text(
                                              invite.email,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (invite.status ==
                                                      FriendStatusEnum
                                                          .rejected.label) ||
                                                  (invite.status ==
                                                      FriendStatusEnum
                                                          .invitation.label)
                                              ? GestureDetector(
                                                  onTap: () => UserRepository
                                                      .instance
                                                      .acceptInvite(invite.id),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          AppColors
                                                              .greenColorGradient,
                                                          AppColors.blueButton,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child:
                                                        const Icon(Icons.check),
                                                  ),
                                                )
                                              : const SizedBox(),
                                          const SizedBox(width: 10),
                                          invite.status ==
                                                  FriendStatusEnum
                                                      .invitation.label
                                              ? GestureDetector(
                                                  onTap: () => UserRepository
                                                      .instance
                                                      .rejectInvite(invite.id),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          AppColors
                                                              .redColorGradient,
                                                          AppColors.blueButton,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child:
                                                        const Icon(Icons.close),
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ],
                                  )),
                            )
                          : const SizedBox(),
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
