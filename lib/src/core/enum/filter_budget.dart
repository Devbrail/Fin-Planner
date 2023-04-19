import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../common.dart';

part 'filter_budget.g.dart';

@HiveType(typeId: 22)
enum FilterExpense {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  monthly,
  @HiveField(3)
  yearly,
  @HiveField(4)
  all;

  String name(BuildContext context) {
    switch (this) {
      case FilterExpense.daily:
        return context.loc.dailyLabel;
      case FilterExpense.weekly:
        return context.loc.weeklyLabel;
      case FilterExpense.monthly:
        return context.loc.monthlyLabel;
      case FilterExpense.yearly:
        return context.loc.yearlyLabel;
      case FilterExpense.all:
        return context.loc.allLabel;
    }
  }
}
