import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AllCategories {
  salary('Wynagrodzenie', FontAwesomeIcons.moneyBill),
  business('Działalność gospodarcza', FontAwesomeIcons.briefcase),
  freelance('Praca zdalna / Freelance', FontAwesomeIcons.houseLaptop),
  investments('Inwestycje', FontAwesomeIcons.chartLine),
  rentalIncome('Dochód z wynajmu', FontAwesomeIcons.building),
  pensions('Emerytura', FontAwesomeIcons.landmark),
  governmentBenefits(
      'Świadczenia socjalne', FontAwesomeIcons.handHoldingDollar),
  bonuses('Premie', FontAwesomeIcons.sackDollar),
  gifts('Prezenty', FontAwesomeIcons.boxOpen),
  dividends('Dywidendy', FontAwesomeIcons.coins),
  royalties('Honoraria', FontAwesomeIcons.copyright),
  refunds('Zwroty', FontAwesomeIcons.receipt),
  other('Inne', FontAwesomeIcons.circleQuestion),
  rentAndMortgage(
      'Mieszkanie i czynsz', FontAwesomeIcons.houseCircleExclamation),
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
  giftsAndDonations('Prezenty i darowizny', FontAwesomeIcons.handsHolding),
  travelAndVacations('Podróże i wakacje', FontAwesomeIcons.plane),
  loansAndInstallments('Raty i pożyczki', FontAwesomeIcons.moneyCheckDollar),
  bankingFeesAndFinance(
      'Opłaty bankowe i finansowe', FontAwesomeIcons.piggyBank),
  pets('Zwierzęta domowe', FontAwesomeIcons.paw),
  repairsAndService('Naprawy i serwis', FontAwesomeIcons.screwdriverWrench),
  savingsAndInvestments(
      'Oszczędności i inwestycje', FontAwesomeIcons.chartLine);

  final String label;
  final IconData icon;

  const AllCategories(this.label, this.icon);

  static IconData returnIcon(String label) {
    return AllCategories.values
        .firstWhere(
          (category) => category.label == label,
          orElse: () => AllCategories.other,
        )
        .icon;
  }
}
