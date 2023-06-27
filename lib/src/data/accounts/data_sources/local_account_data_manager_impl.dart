import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../model/account_model.dart';
import 'local_account_data_manager.dart';

@Singleton(as: LocalAccountDataManager)
class LocalAccountDataManagerImpl implements LocalAccountDataManager {
  LocalAccountDataManagerImpl({
    required this.accountBox,
  });

  final Box<AccountModel> accountBox;

  @override
  List<AccountModel> accounts() => accountBox.values.toList();

  @override
  Future<void> addAccount(AccountModel account) async {
    final int id = await accountBox.add(account);
    account.superId = id;
    return await account.save();
  }

  @override
  Future<void> clearAll() => accountBox.clear();

  @override
  Future<void> deleteAccount(int key) async => accountBox.delete(key);

  @override
  Iterable<AccountModel> exportData() => accountBox.values;

  @override
  AccountModel? fetchAccountFromId(int accountId) {
    return accountBox.values
        .firstWhereOrNull((element) => element.superId == accountId);
  }

  @override
  Future<void> updateAccount(AccountModel accountModel) {
    return accountBox.put(accountModel.superId!, accountModel);
  }
}
