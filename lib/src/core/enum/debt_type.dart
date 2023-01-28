import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../common.dart';

part 'debt_type.g.dart';

@HiveType(typeId: 15)
enum DebtType {
  @HiveField(1)
  debt,
  @HiveField(2)
  credit;

  String name(BuildContext context) {
    switch (this) {
      case DebtType.debt:
        return context.loc.debtLabel;
      case DebtType.credit:
        return context.loc.creditLabel;
    }
  }

  String hintName(BuildContext context) {
    switch (this) {
      case DebtType.debt:
        return context.loc.enterDebtLabel;
      case DebtType.credit:
        return context.loc.enterCreditLabel;
    }
  }
}
