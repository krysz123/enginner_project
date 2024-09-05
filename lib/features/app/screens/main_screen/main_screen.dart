import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/features/app/controllers/main_screen_controller.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/expense_form.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/income_form.dart';
import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(MainScreenController());
    final userController = UserController.instance;
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Obx(
                    () => Animate(
                      effects: const [AlignEffect()],
                      child: Text(
                        '${userController.user.value.totalBalance} PLN',
                        style: TextAppTheme.textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  Text(
                    'Stan konta',
                    style: TextAppTheme.textTheme.labelSmall,
                  ),
                  const SizedBox(height: 70),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Wydatek',
                          height: 50,
                          width: 12,
                          redirection: (() => CustomDialog.customDialog(
                              widget: ExpenseForm(),
                              subtitle: 'Podaj informacje o wydatku',
                              title: 'Dodaj wydatek')),
                          colorGradient1: AppColors.redColorGradient,
                          colorGradient2: AppColors.blueButton,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          text: 'Przychód',
                          height: 50,
                          width: 12,
                          redirection: (() => CustomDialog.customDialog(
                              widget: IncomeForm(),
                              subtitle: 'Podaj informacje o przychodzie',
                              title: 'Dodaj przychód')),
                          colorGradient1: AppColors.greenColorGradient,
                          colorGradient2: AppColors.blueButton,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color:
                      AppColors.secondary, // Set your custom background color
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Moje tranzakcje', // Title above the list
                      style: TextAppTheme.textTheme.titleMedium?.copyWith(
                        color: Colors.white, // Customize title color if needed
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 20, // Example item count
                        itemBuilder: (context, index) {
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.deleteExpenseColor
                                    .withOpacity(0.5),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  size: 30,
                                ),
                              ),
                            ),
                            key: ValueKey<int>(index),
                            child: Card(
                              color: AppColors
                                  .primary, // Set card background color
                              child: ListTile(
                                title: Text('Item $index'),
                                subtitle: Text('Subtitle $index'),
                                trailing: Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 100,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.textSecondaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '1433.00 zł',
                                      style: TextAppTheme.textTheme.titleSmall,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
