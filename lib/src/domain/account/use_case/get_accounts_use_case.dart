import 'package:injectable/injectable.dart';

import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

@injectable
class GetAccountsUseCase {
  final AccountRepository accountRepository;

  GetAccountsUseCase({required this.accountRepository});

  Future<List<Account>> call() => accountRepository.getAccounts();
}
