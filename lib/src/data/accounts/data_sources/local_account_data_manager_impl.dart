import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../model/account_model.dart';
import 'local_account_data_manager.dart';

@Singleton(as: LocalAccountDataManager)
class LocalAccountDataManagerImpl implements LocalAccountDataManager {
  final Box<AccountModel> accountBox;

  LocalAccountDataManagerImpl({
    required this.accountBox,
  });

  @override
  Future<void> addAccount(AccountModel account) async {
    final int id = await accountBox.add(account);
    account.superId = id;
    await account.save();
  }

  @override
  List<AccountModel> accounts() => accountBox.values.toList();

  @override
  Future<void> deleteAccount(int key) async => accountBox.delete(key);

  @override
  Iterable<AccountModel> exportData() => accountBox.values;

  @override
  AccountModel? fetchAccountFromId(int accountId) => accountBox.values
      .firstWhereOrNull((element) => element.superId == accountId);
}
