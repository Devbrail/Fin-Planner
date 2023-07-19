import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';

import '../entities/account.dart';
import '../repository/account_repository.dart';

@singleton
class GetAccountsUseCase {
  GetAccountsUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  List<Account> call() => accountRepository.getAccounts().toEntities();
}
