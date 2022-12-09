import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

class GetAccountsUseCase {
  final AccountRepository accountRepository;

  GetAccountsUseCase({required this.accountRepository});

  Future<List<Account>> call() => accountRepository.getAccounts();
}
