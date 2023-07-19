import 'package:injectable/injectable.dart';

import '../repository/account_repository.dart';

@singleton
class DeleteAccountUseCase {
  DeleteAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  Future<void> call(int key) async => accountRepository.deleteAccount(key);
}
