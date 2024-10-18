import 'package:barcode_widget/barcode_widget.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/loyalty_cards/controllers/lotalty_cards_controller.dart';
import 'package:enginner_project/models/loyalty_card_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyaltyCardsScreen extends StatelessWidget {
  const LoyaltyCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoyaltyCardsController());
    final appBarHeight = DeviceUtility.getAppBarHeight();
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: appBarHeight, right: 30),
            child: IconButton(
              onPressed: () => controller.scanBarcode(),
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<LoyaltyCardModel>>(
                    stream: UserRepository.instance.streamAllLoyaltyCards(),
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
                                Icons.card_membership_rounded,
                                color: AppColors.textSecondaryColor,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Nie masz jeszcze żadnych kart lojalnościowych',
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      }

                      final allLoyaltyCards = snapshot.data!;

                      return ListView.builder(
                        itemCount: allLoyaltyCards.length,
                        itemBuilder: (context, index) {
                          final loyaltyCard = allLoyaltyCards[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: GestureDetector(
                              onLongPress: () => CustomDialog.customDialog(
                                icon: Icons.card_membership_sharp,
                                title: loyaltyCard.title,
                                subtitle: '',
                                widget: BarcodeWidget(
                                  color: Colors.white,
                                  height: 100,
                                  data: loyaltyCard.code,
                                  barcode: Barcode.code128(),
                                ),
                              ),
                              child: Dismissible(
                                key: Key(loyaltyCard.id),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) async {
                                  await UserRepository.instance
                                      .deleteLoyaltyCard(loyaltyCard.id);
                                  Snackbars.infoSnackbar(
                                      title: 'Usunięto!',
                                      message:
                                          '${loyaltyCard.title} został usunięty z twoich kart lojalnościowych');
                                },
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.deleteExpenseColor
                                        .withOpacity(0.5),
                                  ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(
                                      Icons.delete_outline_rounded,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                child: Card(
                                  color: AppColors.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          loyaltyCard.title,
                                          style: TextAppTheme
                                              .textTheme.headlineSmall,
                                        ),
                                        const SizedBox(height: 10),
                                        BarcodeWidget(
                                          color: Colors.white,
                                          height: 100,
                                          data: loyaltyCard.code,
                                          barcode: Barcode.code128(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
