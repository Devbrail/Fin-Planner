import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account_model.dart';

abstract class AccountRepository {
  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
  });
  Future<void> deleteAccount(int key);
  Future<void> updateAccount(AccountModel account);
  AccountModel? fetchAccountFromId(int accountId);
  List<AccountModel> getAccounts();
}
