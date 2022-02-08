import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../../expense/model/expense.dart';
import '../model/account.dart';
import 'account_data_source.dart';

class AccountLocalDataSource implements AccountDataSource {
  late final box = Hive.box<Account>(BoxType.accounts.stringValue);
  @override
  Future<void> addAccount(Account account) async {
    final int id = await box.add(account);
    account.superId = id;
    account.save();
  }

  @override
  Future<void> deleteAccount(int key) async {
    final expenseBox = Hive.box<Expense>(BoxType.expense.stringValue);
    final keys = expenseBox.values
        .where((element) => element.accountId == key)
        .map((e) => e.key);
    expenseBox.deleteAll(keys);
    return box.delete(key);
  }

  @override
  Future<List<Account>> accounts() async {
    final accounts = box.values.toList();
    accounts.sort((a, b) => a.name.compareTo(b.name));
    return accounts;
  }

  @override
  Account fetchAccount(int accountId) {
    return box.values.firstWhere((element) => element.key == accountId);
  }
}
