import 'package:flutter/material.dart';

import '../common.dart';

enum FilterBudget {
  daily,
  weekly,
  monthly,
  yearly,
  all;

  String name(BuildContext context) {
    switch (this) {
      case FilterBudget.daily:
        return context.loc.dailyLabel;
      case FilterBudget.weekly:
        return context.loc.weeklyLabel;
      case FilterBudget.monthly:
        return context.loc.monthlyLabel;
      case FilterBudget.yearly:
        return context.loc.yearlyLabel;
      case FilterBudget.all:
        return context.loc.allLabel;
    }
  }
}
