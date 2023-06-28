import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../interface/result.dart';
import '../model/account_model.dart';

abstract class AccountLocalDataSource implements Result<AccountModel> {}

@Singleton(as: AccountLocalDataSource)
class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  AccountLocalDataSourceImpl({
    required this.accountBox,
  });

  final Box<AccountModel> accountBox;

  @override
  Future<void> add(AccountModel data) async {
    try {
      final int id = await accountBox.add(data);
      data.superId = id;
      return data.save();
    } catch (er) {
      throw NotableToAddException();
    }
  }

  @override
  Iterable<AccountModel> all() {
    final accounts = accountBox.values;
    if (accounts.isNotEmpty) {
      return accounts;
    } else {
      throw NoItemsException();
    }
  }

  @override
  Future<void> delete(int id) {
    try {
      return accountBox.delete(id);
    } catch (er) {
      throw NotableToDeleteException(er);
    }
  }

  @override
  AccountModel? find(int id) {
    return accountBox.get(id);
  }

  @override
  Future<void> update(AccountModel data) {
    return accountBox.put(data.superId!, data);
  }

  @override
  Future<int> clear() {
    try {
      return accountBox.clear();
    } catch (er) {
      throw NotableToDeleteException(er);
    }
  }
}
