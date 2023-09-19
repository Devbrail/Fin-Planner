import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/debit/domain/repository/debit_repository.dart';

@singleton
class DeleteDebitTransactionsByDebitIdUseCase
    implements UseCase<void, DeleteDebitTransactionsDebitIdParams> {
  DeleteDebitTransactionsByDebitIdUseCase({required this.debtRepository});

  final DebitRepository debtRepository;

  @override
  Future<void> call(DeleteDebitTransactionsDebitIdParams params) {
    return debtRepository.deleteDebitTransactionsFromDebitId(
      params.debitTransactionId,
    );
  }
}

class DeleteDebitTransactionsDebitIdParams extends Equatable {
  const DeleteDebitTransactionsDebitIdParams(this.debitTransactionId);

  final int debitTransactionId;

  @override
  List<Object?> get props => [debitTransactionId];
}
