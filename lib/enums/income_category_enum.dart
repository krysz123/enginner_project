import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum IncomeCategory {
  salary('Wynagrodzenie', FontAwesomeIcons.moneyBill),
  business('Działalność gospodarcza', FontAwesomeIcons.briefcase),
  freelance('Praca zdalna / Freelance', FontAwesomeIcons.houseLaptop),
  investments('Inwestycje', FontAwesomeIcons.chartLine),
  rentalIncome('Dochód z wynajmu', FontAwesomeIcons.house),
  pensions('Emerytura', FontAwesomeIcons.landmark),
  governmentBenefits(
      'Świadczenia socjalne', FontAwesomeIcons.handHoldingDollar),
  bonuses('Premie', FontAwesomeIcons.gift),
  gifts('Prezenty', FontAwesomeIcons.gifts),
  dividends('Dywidendy', FontAwesomeIcons.coins),
  royalties('Honoraria', FontAwesomeIcons.copyright),
  refunds('Zwroty', FontAwesomeIcons.receipt),
  other('Inne', FontAwesomeIcons.circleQuestion);

  final String label;
  final IconData icon;

  const IncomeCategory(this.label, this.icon);

  static IconData returnIcon(String label) {
    return IncomeCategory.values
        .firstWhere(
          (category) => category.label == label,
          orElse: () => IncomeCategory.other,
        )
        .icon;
  }
}
