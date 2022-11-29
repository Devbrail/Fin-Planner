import '../model/account.dart';

abstract class AccountLocalDataSource {
  Future<void> addAccount(Account account);
  Future<void> deleteAccount(int key);
  Future<List<Account>> accounts();
  Account? fetchAccountFromId(int accountId);
  Future<Iterable<Account>> exportData();
  Account fetchAccount(int accountId);
}
