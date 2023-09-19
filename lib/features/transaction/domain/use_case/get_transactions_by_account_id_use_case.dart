import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart';

@singleton
class GetTransactionsByAccountIdUseCase
    implements
        UseCase<List<TransactionEntity>, GetTransactionsByAccountIdParams> {
  GetTransactionsByAccountIdUseCase({required this.expenseRepository});

  final TransactionRepository expenseRepository;

  @override
  List<TransactionEntity> call(GetTransactionsByAccountIdParams params) =>
      expenseRepository
          .fetchExpensesFromAccountId(params.accountId)
          .toEntities();
}

class GetTransactionsByAccountIdParams {
  GetTransactionsByAccountIdParams(this.accountId);

  final int accountId;
}
