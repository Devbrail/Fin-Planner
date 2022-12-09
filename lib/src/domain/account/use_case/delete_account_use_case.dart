import '../repository/account_repository.dart';

class DeleteAccountUseCase {
  final AccountRepository accountRepository;

  DeleteAccountUseCase({required this.accountRepository});

  Future<void> call(int key) async => accountRepository.deleteAccount(key);
}
