import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account_model.dart';

abstract class AccountRepository {
  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  });

  Future<void> updateAccount({
    required int key,
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  });

  Future<void> deleteAccount(int key);

  AccountModel? fetchAccountFromId(int accountId);

  List<AccountModel> getAccounts();

  Future<void> clearAll();
}
