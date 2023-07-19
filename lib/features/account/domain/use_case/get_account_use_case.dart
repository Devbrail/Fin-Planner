import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';

import '../entities/account.dart';
import '../repository/account_repository.dart';

@singleton
class GetAccountUseCase {
  GetAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  Account? call(int pathParameters) =>
      accountRepository.fetchAccountFromId(pathParameters)?.toEntity();
}
