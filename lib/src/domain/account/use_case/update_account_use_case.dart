import 'package:injectable/injectable.dart';
import '../entities/account.dart';

import '../../../core/enum/card_type.dart';
import '../repository/account_repository.dart';

@singleton
class UpdateAccountUseCase {
  final AccountRepository accountRepository;

  UpdateAccountUseCase({required this.accountRepository});

  Future<void> call({required Account account}) {
    return accountRepository.updateAccount(
      bankName: account.bankName,
      holderName: account.name,
      number: account.number,
      cardType: account.cardType ?? CardType.bank,
      amount: account.amount ?? 0.0,
      key: account.superId!,
    );
  }
}
