import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/account/domain/entities/add_account.dart';
import 'package:paisa/features/account/domain/repository/account_repository.dart';

@singleton
class AddAccountUseCase extends UseCase<Future<void>, AddAccount> {
  AddAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<void> call({AddAccount? params}) {
    return accountRepository.addAccount(
      bankName: params!.bankName,
      holderName: params.holderName,
      number: params.number,
      cardType: params.cardType,
      amount: params.amount,
      color: params.color,
    );
  }
}
