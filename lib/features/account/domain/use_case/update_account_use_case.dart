import 'package:injectable/injectable.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/account/domain/repository/account_repository.dart';

@singleton
class UpdateAccountUseCase
    implements UseCase<Future<void>, UpdateAccountParams> {
  UpdateAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<void> call({UpdateAccountParams? params}) {
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

class UpdateAccountParams {
  final String bankName;
  final String holderName;
  final String number;
  final CardType cardType;
  final double amount;
  final int color;
  final int key;

  UpdateAccountParams(
    this.key, {
    required this.bankName,
    required this.holderName,
    required this.number,
    required this.cardType,
    required this.amount,
    required this.color,
  });
}
