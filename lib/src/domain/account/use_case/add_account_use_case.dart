import '../../../core/enum/card_type.dart';
import '../repository/account_repository.dart';

class AddAccountUseCase {
  final AccountRepository accountRepository;

  AddAccountUseCase({required this.accountRepository});

  Future<void> call({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
  }) =>
      accountRepository.addAccount(
        bankName: bankName,
        holderName: holderName,
        number: number,
        cardType: cardType,
        amount: amount,
      );
}
