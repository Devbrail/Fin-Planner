import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/extensions/account_extension.dart';
import '../../../core/use_case/use_case.dart';
import '../entities/account.dart';
import '../repository/account_repository.dart';

@singleton
class GetAccountsUseCase implements UseCase<List<Account>, NoParams> {
  GetAccountsUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Either<Failure, List<Account>> call(NoParams params) {
    return accountRepository.accounts().map((r) => r.toEntities());
  }
}
