import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/debts_types_enum.dart';
import 'package:enginner_project/enums/friend_status_enum.dart';
import 'package:enginner_project/features/app/screens/friends/controllers/debt_screen_controller.dart';
import 'package:enginner_project/features/app/screens/friends/widgets/new_debt_form.dart';
import 'package:enginner_project/models/friend_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DebtScreen extends StatelessWidget {
  const DebtScreen({super.key, required this.friend});

  final FriendModel friend;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DebtsScreenController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => CustomDialog.customDialog(
              title: 'Utwórz rozliczenie',
              subtitle: 'Poproś ${friend.fullname} o zwrócenie pieniędzy',
              widget: NewDebtForm(
                friendId: friend.id,
              ),
              icon: Icons.attach_money_sharp,
            ),
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
        title: Text(
          'Rozliczenia z ${friend.fullname}',
          style: TextAppTheme.textTheme.titleMedium,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => ToggleButtons(
                    isSelected: controller.values,
                    constraints:
                        const BoxConstraints(minHeight: 50, minWidth: 100),
                    borderRadius: BorderRadius.circular(30),
                    onPressed: (index) => controller.switchValues(index),
                    selectedColor: AppColors.greenColorGradient,
                    textStyle: TextAppTheme.textTheme.labelSmall,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DebtsTypesEnum.claims.label),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DebtsTypesEnum.debts.label),
                      )
                    ],
                  ),
                ),
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
                              Icons.money,
                              color: AppColors.textSecondaryColor,
                              size: 50,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Nie masz jeszcze żadnych rozliczeń',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    }

                    final allDebts = snapshot.data!;
                    return ListView.builder(
                      itemCount: allDebts.length,
                      itemBuilder: (context, index) {
                        final debt = allDebts[index];

                        return GestureDetector(
                          onLongPress: () {},
                          child: Obx(
                            () => controller.type.value == debt.fullname
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
                                                    debt.fullname,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextAppTheme
                                                        .textTheme.titleMedium,
                                                  ),
                                                  Text(
                                                    debt.email,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (debt.status ==
                                                FriendStatusEnum
                                                    .invitation.label) ...[
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => UserRepository
                                                        .instance
                                                        .acceptInvite(debt.id),
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            AppColors
                                                                .greenColorGradient,
                                                            AppColors
                                                                .blueButton,
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Icon(
                                                          Icons.check),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        Snackbars.errorSnackbar(
                                                            title: 'adsas',
                                                            message: 'sdas'),
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            AppColors
                                                                .redColorGradient,
                                                            AppColors
                                                                .blueButton,
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Icon(
                                                          Icons.close),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]
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
          ),
        ),
      ),
    );
  }
}
