import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/common.dart';

import '../../expense/model/expense.dart';
import '../model/account.dart';
import 'account_local_data_source.dart';

@Singleton(as: LocalAccountManagerDataSource)
class LocalAccountManagerDataSourceImpl
    implements LocalAccountManagerDataSource {
  final Box<Account> accountBox;
  final Box<Expense> expenseBox;

  LocalAccountManagerDataSourceImpl({
    required this.accountBox,
    required this.expenseBox,
  });

  @override
  Future<void> addAccount(Account account) async {
    final int id = await accountBox.add(account);
    account.superId = id;
    await account.save();
  }

  @override
  List<Account> accounts() => accountBox.values.toList();

  @override
  Future<void> deleteAccount(int key) async {
    final keys = expenseBox.values
        .where((element) => element.accountId == key)
        .map((e) => e.key);
    await expenseBox.deleteAll(keys);
    return accountBox.delete(key);
  }

  @override
  Iterable<Account> exportData() => accountBox.values;

  @override
  Account fetchAccountFromId(int accountId) {
    return accountBox.values.firstWhere((element) {
      return element.superId == accountId;
    });
  }

  @override
  List<Expense> fetchExpensesFromAccountId(int accountId) =>
      expenseBox.expensesFromAccountId(accountId);
}
