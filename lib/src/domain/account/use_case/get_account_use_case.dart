import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

class GetAccountUseCase {
  final AccountRepository repository;

  GetAccountUseCase(this.repository);

  Future<Account?> execute(int accountId) async =>
      repository.fetchAccountFromId(accountId);
}
