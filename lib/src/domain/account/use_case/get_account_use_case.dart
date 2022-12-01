import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

class GetAccountUseCase {
  final AccountRepository accountRepository;

  GetAccountUseCase({required this.accountRepository});

  Account? execute(int accountId) =>
      accountRepository.fetchAccountFromId(accountId);
}
