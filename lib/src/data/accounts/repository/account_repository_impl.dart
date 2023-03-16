import 'package:injectable/injectable.dart';

import '../../../core/enum/card_type.dart';
import '../../../domain/account/repository/account_repository.dart';
import '../data_sources/local_account_data_manager.dart';
import '../model/account_model.dart';

@Singleton(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final LocalAccountDataManager dataSource;

  @override
  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
  }) =>
      dataSource.addAccount(AccountModel(
        name: holderName,
        icon: cardType.icon.codePoint,
        bankName: bankName,
        number: number,
        cardType: cardType,
        amount: amount,
      ));

  @override
  Future<void> deleteAccount(int key) => dataSource.deleteAccount(key);

  @override
  Future<void> updateAccount(AccountModel account) async =>
      dataSource.addAccount(account);

  @override
  AccountModel? fetchAccountFromId(int accountId) =>
      dataSource.fetchAccountFromId(accountId);

  @override
  List<AccountModel> getAccounts() => dataSource.accounts();
}
