import 'package:injectable/injectable.dart';

import '../../../core/extensions/account_extension.dart';
import '../entities/account.dart';
import '../repository/account_repository.dart';

@singleton
class GetAccountUseCase {
  final AccountRepository accountRepository;

  GetAccountUseCase({required this.accountRepository});

  Account? call(int params) =>
      accountRepository.fetchAccountFromId(params)?.toEntity();
}
