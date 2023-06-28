import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/error/failures.dart';
import 'package:paisa/src/core/use_case/use_case.dart';

import '../repository/account_repository.dart';

@singleton
class DeleteAccountUseCase extends UseCase<void, DeleteAccountParam> {
  DeleteAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<Either<Failure, void>> call(DeleteAccountParam params) {
    return accountRepository.delete(params.accountId);
  }
}

class DeleteAccountParam extends Equatable {
  final int accountId;

  const DeleteAccountParam(this.accountId);

  @override
  List<Object?> get props => [accountId];
}
