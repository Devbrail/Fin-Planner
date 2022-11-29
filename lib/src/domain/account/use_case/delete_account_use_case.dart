import 'package:flutter_paisa/src/domain/account/repository/account_repository.dart';

class DeleteAccountUseCase {
  final AccountRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> execute(int key) async => repository.deleteAccount(key);
}
