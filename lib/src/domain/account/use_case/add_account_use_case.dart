import '../../../core/enum/card_type.dart';
import '../repository/account_repository.dart';

class AddAccountUseCase {
  final AccountRepository repository;

  AddAccountUseCase(this.repository);

  Future<void> execute({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
  }) =>
      repository.addAccount(
        bankName: bankName,
        holderName: holderName,
        number: number,
        cardType: cardType,
        amount: amount,
      );
}
