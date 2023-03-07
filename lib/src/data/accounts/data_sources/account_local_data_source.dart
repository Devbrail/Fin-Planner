import '../model/account.dart';

abstract class LocalAccountManagerDataSource {
  Future<void> addAccount(Account account);
  Future<void> deleteAccount(int key);
  List<Account> accounts();
  Account? fetchAccountFromId(int accountId);
  Iterable<Account> exportData();
  Account fetchAccount(int accountId);
}
