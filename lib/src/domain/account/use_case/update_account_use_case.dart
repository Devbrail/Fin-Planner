import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enum/card_type.dart';
import '../entities/account.dart';
import '../repository/account_repository.dart';

@singleton
class UpdateAccountUseCase {
  UpdateAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  Future<void> call({required Account account}) {
    return accountRepository.updateAccount(
      bankName: account.bankName,
      holderName: account.name,
      number: account.number,
      cardType: account.cardType ?? CardType.bank,
      amount: account.amount ?? 0.0,
      key: account.superId!,
      color: account.color ?? Colors.brown.shade400.value,
    );
  }
}
