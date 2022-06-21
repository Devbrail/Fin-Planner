import 'package:hive_flutter/adapters.dart';

import '../model/account.dart';

abstract class AccountDataSource {
  Future<void> addAccount(Account account);
  Future<void> deleteAccount(int key);
  Future<List<Account>> accounts();
  Account fetchAccount(int accountId);
  Box<Account> getBox();
}
