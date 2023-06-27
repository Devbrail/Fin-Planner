import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../interface/result.dart';
import '../model/account_model.dart';

abstract class AccountLocalDataSource {
  Future<void> addAccount(AccountModel account);

  Future<void> deleteAccount(int key);

  Iterable<AccountModel> accounts();

  AccountModel? fetchAccountFromId(int accountId);

  Future<void> updateAccount(AccountModel accountModel);

  Future<void> clearAll();
}

@Singleton(as: AccountLocalDataSource)
class AccountLocalDataSourceImpl
    implements AccountLocalDataSource, Result<AccountModel> {
  AccountLocalDataSourceImpl({
    required this.accountBox,
  });

  final Box<AccountModel> accountBox;

  @override
  Iterable<AccountModel> accounts() {
    final accounts = accountBox.values;
    if (accounts.isNotEmpty) {
      return accounts;
    } else {
      throw NoItemsException();
    }
  }

  @override
  Future<void> add(AccountModel data) async {
    final int id = await accountBox.add(data);
    data.superId = id;
    return data.save();
  }

  @override
  Future<void> addAccount(AccountModel account) async {
    final int id = await accountBox.add(account);
    account.superId = id;
    return account.save();
  }

  @override
  Iterable<AccountModel> all() {
    return accountBox.values;
  }

  @override
  Future<void> clearAll() => accountBox.clear();

  @override
  Future<void> delete(int id) {
    return accountBox.delete(id);
  }

  @override
  Future<void> deleteAccount(int key) async => accountBox.delete(key);

  @override
  AccountModel? fetchAccountFromId(int accountId) {
    return accountBox.values
        .firstWhereOrNull((element) => element.superId == accountId);
  }

  @override
  AccountModel? single(int id) {
    return accountBox.get(id);
  }

  @override
  Future<void> update(AccountModel data) {
    return accountBox.put(data.superId!, data);
  }

  @override
  Future<void> updateAccount(AccountModel accountModel) {
    return accountBox.put(accountModel.superId!, accountModel);
  }
}
