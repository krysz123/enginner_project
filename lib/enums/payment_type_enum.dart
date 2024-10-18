enum PaymentTypeEnum {
  cash('Gotówka'),
  card('Karta kredytowa');

  final String label;

  const PaymentTypeEnum(this.label);
}
