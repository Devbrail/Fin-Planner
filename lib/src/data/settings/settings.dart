import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../core/enum/filter_budget.dart';

const selectedFilterExpenseKey = "selected_filter_expense_key";
const selectedHomeFilterExpenseKey = "selected_home_filter_expense_key";
const defaultAccountIdKey = "default_account_id_key";

@singleton
class Settings {
  final Box<dynamic> settings;

  Settings(@Named('settings') this.settings);

  FilterExpense fetchFilterExpense({
    bool isHome = false,
  }) {
    return settings.get(
        isHome ? selectedHomeFilterExpenseKey : selectedFilterExpenseKey,
        defaultValue: FilterExpense.daily);
  }

  Future<void> setFilterExpense(
    FilterExpense expense, {
    bool isHome = false,
  }) async =>
      settings.put(
          isHome ? selectedHomeFilterExpenseKey : selectedFilterExpenseKey,
          expense);

  int? get defaultAccountId => settings.get(defaultAccountIdKey);

  Future<void> setDefaultAccountId(int accountId) async =>
      settings.put(defaultAccountIdKey, accountId);
}
