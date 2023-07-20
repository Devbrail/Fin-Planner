import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/account/domain/repository/account_repository.dart';

@singleton
class DeleteAccountUseCase
    implements UseCase<Future<void>, DeleteAccountParams> {
  DeleteAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<void> call({DeleteAccountParams? params}) {
    return accountRepository.deleteAccount(params!.accountId);
  }
}

class DeleteAccountParams {
  DeleteAccountParams(this.accountId);

  final int accountId;
}
