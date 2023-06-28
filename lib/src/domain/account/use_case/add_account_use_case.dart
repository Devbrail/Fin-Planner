import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enum/card_type.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case/use_case.dart';
import '../repository/account_repository.dart';

@singleton
class AddAccountUseCase extends UseCase<void, AddAccountParams> {
  AddAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<Either<Failure, void>> call(AddAccountParams params) {
    return accountRepository.add(
      bankName: params.bankName,
      holderName: params.holderName,
      number: params.number,
      cardType: params.cardType,
      amount: params.amount,
      color: params.color,
    );
  }
}

class AddAccountParams {
  final String bankName;
  final String holderName;
  final String number;
  final CardType cardType;
  final double amount;
  final int color;

  AddAccountParams({
    required this.bankName,
    required this.holderName,
    required this.number,
    required this.cardType,
    required this.amount,
    required this.color,
  });
}
