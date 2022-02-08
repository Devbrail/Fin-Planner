import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../../expense/model/expense.dart';
import '../model/account.dart';
import 'account_data_source.dart';

class AccountLocalDataSource implements AccountDataSource {
  @override
  Future<void> addAccount(Account account) async {
    final box = Hive.box<Account>(BoxType.accounts.stringValue);
    if (box.containsKey(account.key)) {
      _updateExpenses(account);
      box.put(account.key, account);
    } else {
      box.add(account);
    }
  }

  @override
  Future<void> deleteAccount(int key) async {
    final box = Hive.box<Account>(BoxType.accounts.stringValue);
    final expenseBox = Hive.box<Expense>(BoxType.expense.stringValue);
    final keys = expenseBox.values
        .where((element) => element.account.key == key)
        .map((e) => e.key);
    expenseBox.deleteAll(keys);
    return box.delete(key);
  }

  @override
  Future<List<Account>> accounts() async {
    final box = Hive.box<Account>(BoxType.accounts.stringValue);
    final accounts = box.values.toList();
    accounts.sort((a, b) => a.name.compareTo(b.name));
    return accounts;
  }

  void _updateExpenses(Account account) {
    final expenseBox = Hive.box<Expense>(BoxType.expense.stringValue);
    expenseBox.values.map((e) => e.account.key == account.key).map((e) {
      if (expenseBox.containsKey(e)) {}
    });
  }
}
