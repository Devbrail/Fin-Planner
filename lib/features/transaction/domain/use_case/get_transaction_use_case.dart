import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart';

@singleton
class GetTransactionUseCase
    implements UseCase<Future<TransactionEntity?>, GetTransactionParams> {
  GetTransactionUseCase({required this.transactionRepository});

  final TransactionRepository transactionRepository;

  @override
  Future<TransactionEntity?> call(GetTransactionParams params) async =>
      transactionRepository
          .fetchExpenseFromId(params.transactionId)
          ?.toEntity();
}

class GetTransactionParams {
  GetTransactionParams(this.transactionId);

  final int transactionId;
}
