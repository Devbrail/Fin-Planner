import 'package:hive_flutter/adapters.dart';

import '../model/account.dart';

abstract class AccountLocalDataSource {
  Future<void> addAccount(Account account);
  Future<void> deleteAccount(int key);
  Future<List<Account>> accounts();
  Account fetchAccount(int accountId);
  Box<Account> getBox();
  Future<Account?> fetchAccountFromId(int accountId);
  Future<Iterable<Account>> exportData();
}
