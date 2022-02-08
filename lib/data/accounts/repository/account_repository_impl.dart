import '../../../common/enum/card_type.dart';
import '../../../domain/account/repository/account_repository.dart';
import '../datasources/account_data_source.dart';
import '../model/account.dart';

class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final AccountDataSource dataSource;

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
    required int icon,
    required DateTime validThru,
    required CardType cardType,
  }) async {
    await dataSource.addAccount(Account(
      name: holderName,
      icon: icon,
      bankName: bankName,
      number: number,
      validThru: validThru,
      cardType: cardType,
    ));
  }

  @override
  Future<void> deleteAccount(int key) async {
    await dataSource.deleteAccount(key);
  }

  @override
  Future<void> updateAccount(Account account) async {
    await dataSource.addAccount(account);
  }
}
