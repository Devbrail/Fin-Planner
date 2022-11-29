import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'card_type.g.dart';

@HiveType(typeId: 12)
enum CardType {
  @HiveField(0)
  cash,
  @HiveField(1)
  bank,
  @HiveField(2)
  wallet,
}

extension CardTypeMapping on CardType {
  String get name {
    switch (this) {
      case CardType.cash:
        return 'Cash';
      case CardType.bank:
        return 'Bank';
      case CardType.wallet:
        return 'Wallet';
    }
  }

  IconData get icon {
    switch (this) {
      case CardType.cash:
        return MdiIcons.cashMultiple;
      case CardType.bank:
        return MdiIcons.creditCardChip;
      case CardType.wallet:
        return MdiIcons.creditCard;
    }
  }
}

extension CardTypeMap on String {
  CardType get type {
    switch (this) {
      case 'Cash':
        return CardType.cash;
      case 'Bank':
        return CardType.bank;
      case 'Wallet':
        return CardType.wallet;
    }
    return CardType.bank;
  }
}
