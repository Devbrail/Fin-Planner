import '../model/account_model.dart';

abstract class LocalAccountDataManager {
  Future<void> addAccount(AccountModel account);
  Future<void> deleteAccount(int key);
  List<AccountModel> accounts();
  AccountModel? fetchAccountFromId(int accountId);
  Iterable<AccountModel> exportData();
}
