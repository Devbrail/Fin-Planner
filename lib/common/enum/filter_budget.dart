import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FilterBudget {
  daily,
  weekly,
  monthly,
  yearly,
  all,
}

extension FilterBudgetMapping on FilterBudget {
  String name(BuildContext context) {
    switch (this) {
      case FilterBudget.daily:
        return AppLocalizations.of(context)!.dailyLable;
      case FilterBudget.weekly:
        return AppLocalizations.of(context)!.weeklyLable;
      case FilterBudget.monthly:
        return AppLocalizations.of(context)!.monthlyLable;
      case FilterBudget.yearly:
        return AppLocalizations.of(context)!.yearlyLable;
      case FilterBudget.all:
        return AppLocalizations.of(context)!.allLable;
    }
  }
}
