import '../../../common/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

class AccountUseCase {
  final AccountRepository repository;

  AccountUseCase({required this.repository});
  Future<List<Account>> accounts() async {
    return repository.accounts();
  }

  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
  }) async {
    await repository.addAccount(
      bankName: bankName,
      holderName: holderName,
      number: number,
      cardType: cardType,
    );
  }

  Future<void> deleteAccount(int key) {
    return repository.deleteAccount(key);
  }

  Future<void> updateAccount(Account account) async {
    return await repository.updateAccount(account);
  }

  Future<Account?> fetchAccountFromId(int expenseId) async =>
      repository.fetchAccountFromId(expenseId);
}
