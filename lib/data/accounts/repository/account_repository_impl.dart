import '../../../common/enum/card_type.dart';
import '../../../domain/account/repository/account_repository.dart';
import '../data_sources/account_local_data_source.dart';
import '../model/account.dart';

class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final AccountLocalDataSource dataSource;

  @override
  Future<List<Account>> accounts() async {
    final accounts = await dataSource.accounts();
    accounts.sort((a, b) => a.name.compareTo(b.name));
    return accounts;
  }

  @override
  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
  }) async {
    await dataSource.addAccount(Account(
      name: holderName,
      icon: cardType.icon.codePoint,
      bankName: bankName,
      number: number,
      cardType: cardType,
    ));
  }

  @override
  Future<void> deleteAccount(int key) {
    return dataSource.deleteAccount(key);
  }

  @override
  Future<void> updateAccount(Account account) async {
    await dataSource.addAccount(account);
  }

  @override
  Future<Account?> fetchAccountFromId(int accountId) =>
      dataSource.fetchAccountFromId(accountId);
}
