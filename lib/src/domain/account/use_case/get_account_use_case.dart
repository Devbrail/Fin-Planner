import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

class GetAccountUseCase {
  final AccountRepository repository;

  GetAccountUseCase(this.repository);

  Account? execute(int accountId) => repository.fetchAccountFromId(accountId);
}
