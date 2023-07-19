import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/account/domain/entities/update_account.dart';
import 'package:paisa/features/account/domain/repository/account_repository.dart';

@singleton
class UpdateAccountUseCase implements UseCase<Future<void>, UpdateAccount> {
  UpdateAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<void> call({UpdateAccount? params}) {
    return accountRepository.updateAccount(
      bankName: params!.bankName,
      holderName: params.holderName,
      number: params.number,
      cardType: params.cardType,
      amount: params.amount,
      key: params.key,
      color: params.color,
    );
  }
}
