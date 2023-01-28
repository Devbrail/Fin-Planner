import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'card_type.g.dart';

@HiveType(typeId: 12)
enum CardType {
  @HiveField(0)
  cash(
    name: 'Cash',
    icon: MdiIcons.cashMultiple,
  ),
  @HiveField(1)
  bank(
    name: 'Bank',
    icon: MdiIcons.creditCardChip,
  ),
  @HiveField(2)
  wallet(
    name: 'Wallet',
    icon: MdiIcons.creditCard,
  );

  final String name;
  final IconData icon;

  const CardType({
    required this.name,
    required this.icon,
  });
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
