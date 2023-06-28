import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/error/failures.dart';

import '../../../core/extensions/account_extension.dart';
import '../../../core/use_case/use_case.dart';
import '../entities/account.dart';
import '../repository/account_repository.dart';

@singleton
class GetAccountUseCase extends UseCase<Account, AccountParam> {
  GetAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<Either<Failure, Account>> call(AccountParam params) async {
    return accountRepository.find(params.accountId).map((r) => r.toEntity());
  }
}

class AccountParam extends Equatable {
  final int accountId;

  const AccountParam(this.accountId);

  @override
  List<Object?> get props => [accountId];
}
