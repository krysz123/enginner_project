import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/expense_form.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/income_form.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/popups/custom_dialog.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          StreamBuilder(
            stream: UserRepository.instance.streamTotalBalance(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Błąd: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('Brak danych');
              }

              final totalBalance = snapshot.data ?? 0.0;
              return Text('$totalBalance PLN',
                  style: TextAppTheme.textTheme.headlineSmall);
            },
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
                      icon: Icons.add,
                      widget: const ExpenseForm(),
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
                      icon: Icons.add,
                      widget: const IncomeForm(),
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
    );
  }
}
