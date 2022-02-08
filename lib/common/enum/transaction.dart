import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 11)
enum TransactonType {
  @HiveField(1)
  expense,
  @HiveField(0)
  income,
  @HiveField(2)
  deposit
}

extension TransactonTypeMapping on TransactonType {
  String name(BuildContext context) {
    switch (this) {
      case TransactonType.income:
        return AppLocalizations.of(context)!.income;
      case TransactonType.expense:
        return AppLocalizations.of(context)!.expense;
      case TransactonType.deposit:
        return AppLocalizations.of(context)!.deposit;
    }
  }
}
