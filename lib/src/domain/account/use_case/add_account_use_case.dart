import 'package:injectable/injectable.dart';

import '../../../core/enum/card_type.dart';
import '../repository/account_repository.dart';

@singleton
class AddAccountUseCase {
  AddAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  Future<void> call({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  }) =>
      accountRepository.addAccount(
        bankName: bankName,
        holderName: holderName,
        number: number,
        cardType: cardType,
        amount: amount,
        color: color,
      );
}
