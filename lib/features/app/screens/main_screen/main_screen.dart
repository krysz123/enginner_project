import 'package:enginner_project/features/app/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/balance_section.dart';
import 'package:enginner_project/features/app/screens/main_screen/widgets/transactions_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainScreenController());

    return SafeArea(
      child: Column(
        children: [
          const BalanceSection(),
          const SizedBox(height: 20),
          TransactionsSection(controller: controller),
        ],
      ),
    );
  }
}
