enum IncomeCategory {
  salary('Wynagrodzenie'),
  business('Działalność gospodarcza'),
  freelance('Praca zdalna / Freelance'),
  investments('Inwestycje'),
  rentalIncome('Dochód z wynajmu'),
  pensions('Emerytura'),
  governmentBenefits('Świadczenia socjalne'),
  bonuses('Premie'),
  gifts('Prezenty'),
  dividends('Dywidendy'),
  royalties('Honoraria'),
  refunds('Zwroty'),
  other('Inne');

  final String label;

  const IncomeCategory(this.label);
}
