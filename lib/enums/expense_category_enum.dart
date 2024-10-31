import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ExpenseCategory {
  rentAndMortgage('Mieszkanie i czynsz', FontAwesomeIcons.house),
  utilities('Media', FontAwesomeIcons.lightbulb),
  internetAndPhone('Internet i telefon', FontAwesomeIcons.wifi),
  food('Żywność', FontAwesomeIcons.utensils),
  transport('Transport', FontAwesomeIcons.bus),
  insurance('Ubezpieczenia', FontAwesomeIcons.shieldHalved),
  education('Edukacja', FontAwesomeIcons.book),
  health('Zdrowie', FontAwesomeIcons.heartPulse),
  hygieneAndCosmetics('Higiena i kosmetyki', FontAwesomeIcons.soap),
  entertainmentAndCulture('Rozrywka i kultura', FontAwesomeIcons.film),
  clothingAndFootwear('Odzież i obuwie', FontAwesomeIcons.shirt),
  sportsAndRecreation('Sport i rekreacja', FontAwesomeIcons.dumbbell),
  children('Dzieci', FontAwesomeIcons.baby),
  giftsAndDonations('Prezenty i darowizny', FontAwesomeIcons.gift),
  travelAndVacations('Podróże i wakacje', FontAwesomeIcons.plane),
  loansAndInstallments('Raty i pożyczki', FontAwesomeIcons.moneyCheckDollar),
  bankingFeesAndFinance(
      'Opłaty bankowe i finansowe', FontAwesomeIcons.piggyBank),
  pets('Zwierzęta domowe', FontAwesomeIcons.paw),
  repairsAndService('Naprawy i serwis', FontAwesomeIcons.screwdriverWrench),
  savingsAndInvestments(
      'Oszczędności i inwestycje', FontAwesomeIcons.chartLine),
  other('Inne', FontAwesomeIcons.circleQuestion);

  final String label;
  final IconData icon;

  const ExpenseCategory(this.label, this.icon);

  static IconData returnIcon(String label) {
    return ExpenseCategory.values
        .firstWhere(
          (category) => category.label == label,
          orElse: () => ExpenseCategory.other,
        )
        .icon;
  }
}
