import 'package:injectable/injectable.dart';

import '../../../core/enum/card_type.dart';
import '../../../domain/account/repository/account_repository.dart';
import '../data_sources/local_account_data_manager.dart';
import '../model/account_model.dart';

@Singleton(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final AccountLocalDataManager dataSource;

  @override
  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  }) {
    return dataSource.add(AccountModel(
      name: holderName,
      bankName: bankName,
      number: number,
      cardType: cardType,
      amount: amount,
      color: color,
    ));
  }

  @override
  Future<void> clearAll() => dataSource.clear();

  @override
  Future<void> deleteAccount(int key) => dataSource.delete(key);

  @override
  AccountModel? fetchAccountFromId(int accountId) =>
      dataSource.findById(accountId);

  @override
  List<AccountModel> getAccounts() => dataSource.accounts();

  @override
  Future<void> updateAccount({
    required int key,
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  }) {
    return dataSource.update(
      AccountModel(
        name: holderName,
        bankName: bankName,
        number: number,
        cardType: cardType,
        amount: amount,
        superId: key,
        color: color,
      ),
    );
  }
}
