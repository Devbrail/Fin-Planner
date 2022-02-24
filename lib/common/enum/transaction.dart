import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';

import '../../main.dart';

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
  String get name {
    switch (this) {
      case TransactonType.income:
        return AppLocalizations.of(mainNavigator.currentState!.context)!.income;
      case TransactonType.expense:
        return AppLocalizations.of(mainNavigator.currentState!.context)!
            .expense;
      case TransactonType.deposit:
        return AppLocalizations.of(mainNavigator.currentState!.context)!
            .deposit;
    }
  }
}
