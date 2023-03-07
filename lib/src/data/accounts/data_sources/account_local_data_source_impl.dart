import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enum/box_types.dart';
import '../../expense/model/expense.dart';
import '../model/account.dart';
import 'account_local_data_source.dart';

@Singleton(as: LocalAccountManagerDataSource)
class LocalAccountManagerDataSourceImpl
    implements LocalAccountManagerDataSource {
  final Box<Account> accountBox;

  LocalAccountManagerDataSourceImpl(this.accountBox);

  @override
  Future<void> addAccount(Account account) async {
    final int id = await accountBox.add(account);
    account.superId = id;
    await account.save();
  }

  @override
  Future<List<Account>> accounts() async {
    final accounts = accountBox.values.toList();
    accounts.sort((a, b) => a.name.compareTo(b.name));
    return accounts;
  }

  @override
  Account? fetchAccountFromId(int accountId) => accountBox.get(accountId);

  @override
  Future<void> deleteAccount(int key) async {
    final expenseBox = Hive.box<Expense>(BoxType.expense.name);
    final keys = expenseBox.values
        .where((element) => element.accountId == key)
        .map((e) => e.key);
    await expenseBox.deleteAll(keys);
    return accountBox.delete(key);
  }

  @override
  Future<Iterable<Account>> exportData() async => accountBox.values;

  @override
  Account fetchAccount(int accountId) {
    return accountBox.values.firstWhere((element) {
      return element.superId == accountId;
    });
  }
}
