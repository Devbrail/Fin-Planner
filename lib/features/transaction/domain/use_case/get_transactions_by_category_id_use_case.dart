import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart';

@singleton
class GetTransactionsByCategoryIdUseCase extends UseCase<
    List<TransactionEntity>, GetTransactionsByCategoryIdParams> {
  GetTransactionsByCategoryIdUseCase({required this.expenseRepository});

  final TransactionRepository expenseRepository;
  @override
  List<TransactionEntity> call({GetTransactionsByCategoryIdParams? params}) =>
      expenseRepository
          .fetchExpensesFromCategoryId(params!.categoryId)
          .toEntities();
}

class GetTransactionsByCategoryIdParams {
  GetTransactionsByCategoryIdParams(this.categoryId);

  final int categoryId;
}
