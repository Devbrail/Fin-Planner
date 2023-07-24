import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart';

@singleton
class GetTransactionsByCategoryIdUseCase {
  GetTransactionsByCategoryIdUseCase({required this.expenseRepository});

  final TransactionRepository expenseRepository;

  List<TransactionEntity> call(int accountId) =>
      expenseRepository.fetchExpensesFromCategoryId(accountId).toEntities();
}

class GetTransactionsByCategoryIdParams {
  GetTransactionsByCategoryIdParams(this.accountId);

  final int accountId;
}
