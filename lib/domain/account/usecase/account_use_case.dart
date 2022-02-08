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
    required int icon,
    required DateTime validThru,
    required CardType cardType,
  }) async {
    await repository.addAccount(
      bankName: bankName,
      holderName: holderName,
      icon: icon,
      number: number,
      validThru: validThru,
      cardType: cardType,
    );
  }

  Future<void> deleteAccount(int key) async {
    return await repository.deleteAccount(key);
  }

  Future<void> updateAccount(Account account) async {
    return await repository.updateAccount(account);
  }
}
