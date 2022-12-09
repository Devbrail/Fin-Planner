import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

class GetAccountUseCase {
  final AccountRepository accountRepository;

  GetAccountUseCase({required this.accountRepository});

  Account? call(int params) => accountRepository.fetchAccountFromId(params);
}
