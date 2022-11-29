import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../../expense/model/expense.dart';
import '../model/account.dart';
import 'account_local_data_source.dart';

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  late final accountBox = Hive.box<Account>(BoxType.accounts.stringValue);

  @override
  Future<void> addAccount(Account account) async {
    final int id = await accountBox.add(account);
    account.superId = id;
    await account.save();
  }

  @override
  Future<void> deleteAccount(int key) async {
    final expenseBox = Hive.box<Expense>(BoxType.expense.stringValue);
    final keys = expenseBox.values
        .where((element) => element.accountId == key)
        .map((e) => e.key);
    await expenseBox.deleteAll(keys);
    return accountBox.delete(key);
  }

  @override
  Future<List<Account>> accounts() async {
    final accounts = accountBox.values.toList();
    accounts.sort((a, b) => a.name.compareTo(b.name));
    return accounts;
  }

  @override
  Account fetchAccount(int accountId) {
    return accountBox.values.firstWhere((element) {
      return element.superId == accountId;
    });
  }

  @override
  Box<Account> getBox() {
    return accountBox;
  }

  @override
  Future<Account?> fetchAccountFromId(int accountId) async =>
      accountBox.get(accountId);
  @override
  Future<Iterable<Account>> exportData() async => accountBox.values;
}
