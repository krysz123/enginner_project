import 'package:enginner_project/app.dart';
import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/debts_types_enum.dart';
import 'package:enginner_project/enums/friend_status_enum.dart';
import 'package:enginner_project/features/app/screens/friends/controllers/debt_screen_controller.dart';
import 'package:enginner_project/features/app/screens/friends/widgets/debt_card_widget.dart';
import 'package:enginner_project/features/app/screens/friends/widgets/new_debt_form.dart';
import 'package:enginner_project/models/debt_model.dart';
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
                    isSelected: controller.values.toList(),
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
                const SizedBox(height: 20),
                Expanded(
                    child: StreamBuilder(
                  stream: UserRepository.instance.streamAllDebts(friend.id),
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
                          onLongPress: () => (!debt.status &&
                                  debt.type == DebtsTypesEnum.debts.label)
                              ? CustomDialog.customDialog(
                                  title: 'Oznacz jako oddane',
                                  subtitle:
                                      'Poinformuj ${friend.fullname} o oddaniu pieniędzy',
                                  widget: Center(
                                    child: CustomButton(
                                      text: 'Oddaj',
                                      height: 50,
                                      width: 200,
                                      redirection: () {
                                        UserRepository.instance
                                            .setDebtAsReturned(
                                          friend.id,
                                          debt.id,
                                        );
                                        Get.back();
                                      },
                                      colorGradient1:
                                          AppColors.greenColorGradient,
                                      colorGradient2: AppColors.blueButton,
                                    ),
                                  ),
                                  icon: Icons.abc)
                              : () {},
                          child: Obx(
                            () => controller.type.value == debt.type
                                ? DebtCardWidget(debt: debt)
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
