enum ExpenseTypeEnum {
  expense('Wydatek'),
  income('Przychód'),
  periodicExpense('Wydatek stały'),
  periodicIncome('Przychód stały');

  final String label;

  const ExpenseTypeEnum(this.label);
}
