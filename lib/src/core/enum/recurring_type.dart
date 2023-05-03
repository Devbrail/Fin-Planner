import 'package:flutter/material.dart';
import 'package:paisa/src/core/common.dart';

enum RecurringType {
  daily,
  weekly,
  monthly,
  yearly;

  String name(BuildContext context) {
    switch (this) {
      case RecurringType.daily:
        return context.loc.dailyLabel;
      case RecurringType.weekly:
        return context.loc.weeklyLabel;
      case RecurringType.monthly:
        return context.loc.monthlyLabel;
      case RecurringType.yearly:
        return context.loc.yearlyLabel;
    }
  }
}
