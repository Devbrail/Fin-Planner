import 'package:injectable/injectable.dart';

import '../repository/account_repository.dart';

@singleton
class DeleteAccountUseCase {
  final AccountRepository accountRepository;

  DeleteAccountUseCase({required this.accountRepository});

  Future<void> call(int key) async => accountRepository.deleteAccount(key);
}
