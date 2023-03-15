import 'package:paisa/src/data/expense/model/expense.dart';

import '../model/account.dart';

abstract class LocalAccountManagerDataSource {
  Future<void> addAccount(Account account);
  Future<void> deleteAccount(int key);
  List<Account> accounts();
  List<Expense> fetchExpensesFromAccountId(int accountId);
  Account? fetchAccountFromId(int accountId);
  Iterable<Account> exportData();
}
