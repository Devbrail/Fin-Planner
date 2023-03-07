import 'package:injectable/injectable.dart';

import '../../../data/accounts/model/account.dart';
import '../repository/account_repository.dart';

@injectable
class GetAccountUseCase {
  final AccountRepository accountRepository;

  GetAccountUseCase({required this.accountRepository});

  Account? call(int params) => accountRepository.fetchAccountFromId(params);
}
