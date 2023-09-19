import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart';

@singleton
class DeleteTransactionsByAccountIdUseCase
    implements UseCase<void, DeleteTransactionsFromAccountIdParams> {
  DeleteTransactionsByAccountIdUseCase({required this.expenseRepository});

  final TransactionRepository expenseRepository;

  @override
  Future<void> call(DeleteTransactionsFromAccountIdParams params) async =>
      expenseRepository.deleteExpensesByAccountId(params.accountId);
}

class DeleteTransactionsFromAccountIdParams {
  DeleteTransactionsFromAccountIdParams(this.accountId);

  final int accountId;
}
