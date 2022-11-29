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
        return AppLocalizations.of(context)!.dailyLabel;
      case FilterBudget.weekly:
        return AppLocalizations.of(context)!.weeklyLabel;
      case FilterBudget.monthly:
        return AppLocalizations.of(context)!.monthlyLabel;
      case FilterBudget.yearly:
        return AppLocalizations.of(context)!.yearlyLabel;
      case FilterBudget.all:
        return AppLocalizations.of(context)!.allLabel;
    }
  }
}
