import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'card_type.g.dart';

@HiveType(typeId: 12)
enum CardType {
  @HiveField(0)
  cash,
  @HiveField(1)
  debitcard,
  @HiveField(2)
  creditCard,
  @HiveField(3)
  upi
}

extension CardTypeMapping on CardType {
  String get name {
    switch (this) {
      case CardType.cash:
        return 'Cash';
      case CardType.debitcard:
        return 'Debit card';
      case CardType.creditCard:
        return 'Credit card';
      case CardType.upi:
        return 'UPI';
    }
  }

  IconData get icon {
    switch (this) {
      case CardType.cash:
        return Icons.attach_money;
      case CardType.debitcard:
        return Icons.local_atm;
      case CardType.creditCard:
        return Icons.credit_card;
      case CardType.upi:
        return Icons.currency_rupee;
    }
  }
}
