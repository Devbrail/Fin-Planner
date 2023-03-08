import 'package:injectable/injectable.dart';

import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

@singleton
class GetAccountsUseCase {
  final AccountRepository accountRepository;

  GetAccountsUseCase({required this.accountRepository});

  List<Account> call() => accountRepository.getAccounts();
}
