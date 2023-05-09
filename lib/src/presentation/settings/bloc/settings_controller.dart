import 'package:injectable/injectable.dart';

import '../../../core/enum/filter_budget.dart';
import '../../../data/settings/settings.dart';

@singleton
class SettingsController {
  final Settings settings;

  SettingsController(this.settings);

  FilterExpense fetchFilterExpense({bool isHome = false}) =>
      settings.fetchFilterExpense(isHome: isHome);

  Future<void> setFilterExpense(
    FilterExpense expense, {
    bool isHome = false,
  }) async =>
      settings.setFilterExpense(
        expense,
        isHome: isHome,
      );

  int? get defaultAccountId => settings.defaultAccountId;

  Future<void> setDefaultAccountId(int accountId) async =>
      settings.setDefaultAccountId(accountId);
}
