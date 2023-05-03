import 'package:injectable/injectable.dart';

import '../../../core/enum/filter_budget.dart';
import '../../../data/settings/settings.dart';

@singleton
class SettingsController {
  final Settings settings;

  SettingsController(this.settings);

  FilterExpense get fetchFilterExpense => settings.fetchFilterExpense;
  FilterThisExpense get fetchFilterThisExpense =>
      settings.fetchFilterThisExpense;

  Future<void> setFilterExpense(FilterExpense expense) async =>
      settings.setFilterExpense(expense);

  Future<void> setFilterThisExpense(FilterThisExpense expense) async =>
      settings.setFilterThisExpense(expense);

  int? get defaultAccountId => settings.defaultAccountId;

  Future<void> setDefaultAccountId(int accountId) async =>
      settings.setDefaultAccountId(accountId);
}
