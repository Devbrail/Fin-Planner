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
        return AppLocalizations.of(context)!.daily;
      case FilterBudget.weekly:
        return AppLocalizations.of(context)!.weekly;
      case FilterBudget.monthly:
        return AppLocalizations.of(context)!.monthly;
      case FilterBudget.yearly:
        return AppLocalizations.of(context)!.yearly;
      case FilterBudget.all:
        return AppLocalizations.of(context)!.all;
    }
  }
}
