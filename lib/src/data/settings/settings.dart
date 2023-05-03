import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../core/enum/filter_budget.dart';

const selectedFilterExpenseKey = "selected_filter_expense_key";
const selectedFilterThisExpenseKey = "selected_this_filter_expense_key";
const defaultAccountIdKey = "default_account_id_key";

@singleton
class Settings {
  final Box<dynamic> settings;

  Settings(@Named('settings') this.settings);

  FilterExpense get fetchFilterExpense {
    return settings.get(selectedFilterExpenseKey,
        defaultValue: FilterExpense.daily);
  }

  FilterThisExpense get fetchFilterThisExpense {
    return settings.get(selectedFilterThisExpenseKey,
        defaultValue: FilterThisExpense.today);
  }

  Future<void> setFilterExpense(FilterExpense expense) async =>
      settings.put(selectedFilterExpenseKey, expense);

  Future<void> setFilterThisExpense(FilterThisExpense expense) async =>
      settings.put(selectedFilterThisExpenseKey, expense);

  int? get defaultAccountId => settings.get(defaultAccountIdKey);

  Future<void> setDefaultAccountId(int accountId) async =>
      settings.put(defaultAccountIdKey, accountId);
}
