import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/account/domain/repository/account_repository.dart';

@singleton
class DeleteAccountUseCase extends UseCase<Future<void>, int> {
  DeleteAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<void> call({int? params}) {
    return accountRepository.deleteAccount(params!);
  }
}
