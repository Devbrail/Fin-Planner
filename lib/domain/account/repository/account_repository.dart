import '../../../common/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';

abstract class AccountRepository {
  Future<List<Account>> accounts();
  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required int icon,
    required DateTime validThru,
    required CardType cardType,
  });
  Future<void> deleteAccount(int key);

  Future<void> updateAccount(Account account);
}
