import 'package:injectable/injectable.dart';

import '../../../core/enum/filter_expense.dart';
import '../../../data/settings/settings.dart';

@singleton
class SettingsController {
  SettingsController(this.settings);

  final Settings settings;

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

  dynamic get(String key, {dynamic defaultValue}) =>
      settings.get(key, defaultValue: defaultValue);

  Future<void> put(String key, dynamic value) => settings.put(key, value);

  Future<void> delete(String key) => settings.delete(key);
}
