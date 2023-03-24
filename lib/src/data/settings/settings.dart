import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../core/enum/filter_budget.dart';

const selectedFilterExpenseKey = "selected_filter_expense_key";

@singleton
class Settings {
  final Box<dynamic> settings;

  Settings(@Named('settings') this.settings);

  FilterExpense get fetchFilterExpense {
    return settings.get(selectedFilterExpenseKey,
        defaultValue: FilterExpense.daily);
  }

  Future<void> setFilterExpense(FilterExpense expense) async =>
      settings.put(selectedFilterExpenseKey, expense);
}
