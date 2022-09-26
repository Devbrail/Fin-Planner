import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/common/enum/card_type.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 11)
enum TransactonType {
  @HiveField(1)
  expense,
  @HiveField(0)
  income /* ,
  @HiveField(2)
  deposit */
}

extension TransactonTypeMapping on TransactonType {
  String name(BuildContext context) {
    switch (this) {
      case TransactonType.income:
        return AppLocalizations.of(context)!.incomeLable;
      case TransactonType.expense:
        return AppLocalizations.of(context)!.expenseLable;
      /*  case TransactonType.deposit:
        return AppLocalizations.of(context)!.deposit; */
    }
  }

  String get nameString {
    switch (this) {
      case TransactonType.expense:
        return 'expense';
      case TransactonType.income:
        return 'income';
    }
  }
}

extension TransactionMap on String {
  TransactonType get type {
    switch (this) {
      case 'expense':
        return TransactonType.expense;
      case 'income':
        return TransactonType.income;
    }
    return TransactonType.expense;
  }
}
