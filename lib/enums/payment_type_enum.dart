import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PaymentTypeEnum {
  cash('Gotówka', FontAwesomeIcons.moneyBill),
  card('Karta kredytowa', FontAwesomeIcons.creditCard),
  other('Inne', FontAwesomeIcons.circleQuestion);

  final String label;
  final IconData icon;

  const PaymentTypeEnum(this.label, this.icon);

  static IconData returnIcon(String label) {
    return PaymentTypeEnum.values
        .firstWhere(
          (category) => category.label == label,
          orElse: () => PaymentTypeEnum.other,
        )
        .icon;
  }
}
