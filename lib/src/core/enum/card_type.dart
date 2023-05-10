import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'card_type.g.dart';

@HiveType(typeId: 12)
enum CardType {
  @HiveField(0)
  cash(icon: MdiIcons.cashMultiple),
  @HiveField(1)
  bank(icon: MdiIcons.creditCardChip),
  @HiveField(2)
  wallet(icon: MdiIcons.creditCard);

  final IconData icon;

  const CardType({
    required this.icon,
  });
}
