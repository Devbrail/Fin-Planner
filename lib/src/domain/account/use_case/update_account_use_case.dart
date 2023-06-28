import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/error/failures.dart';
import 'package:paisa/src/core/use_case/use_case.dart';

import '../../../core/enum/card_type.dart';
import '../entities/account.dart';
import '../repository/account_repository.dart';

@singleton
class UpdateAccountUseCase extends UseCase<void, Account> {
  UpdateAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;
  @override
  Future<Either<Failure, void>> call(Account params) async {
    return accountRepository.update(
      bankName: params.bankName,
      holderName: params.name,
      number: params.number,
      cardType: params.cardType ?? CardType.bank,
      amount: params.amount ?? 0.0,
      key: params.superId!,
      color: params.color ?? Colors.brown.shade400.value,
    );
  }
}
