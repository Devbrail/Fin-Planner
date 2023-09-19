import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart';

@singleton
class GetTransactionsUseCase
    implements UseCase<List<TransactionEntity>, NoParams> {
  GetTransactionsUseCase({required this.expenseRepository});

  final TransactionRepository expenseRepository;
  @override
  List<TransactionEntity> call(NoParams params) {
    return expenseRepository.expenses().toEntities();
  }
}
