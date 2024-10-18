enum ExpenseCategory {
  rentAndMortgage('Mieszkanie i czynsz'),
  utilities('Media'),
  internetAndPhone('Internet i telefon'),
  food('Żywność'),
  transport('Transport'),
  insurance('Ubezpieczenia'),
  education('Edukacja'),
  health('Zdrowie'),
  hygieneAndCosmetics('Higiena i kosmetyki'),
  entertainmentAndCulture('Rozrywka i kultura'),
  clothingAndFootwear('Odzież i obuwie'),
  sportsAndRecreation('Sport i rekreacja'),
  children('Dzieci'),
  giftsAndDonations('Prezenty i darowizny'),
  travelAndVacations('Podróże i wakacje'),
  loansAndInstallments('Raty i pożyczki'),
  bankingFeesAndFinance('Opłaty bankowe i finansowe'),
  pets('Zwierzęta domowe'),
  repairsAndService('Naprawy i serwis'),
  savingsAndInvestments('Oszczędności i inwestycje');

  final String label;

  const ExpenseCategory(this.label);
}
