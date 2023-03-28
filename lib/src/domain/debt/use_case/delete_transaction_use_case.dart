import 'package:injectable/injectable.dart';

import '../repository/debit_repository.dart';

@singleton
class DeleteTransactionUseCase {
  final DebtRepository debtRepository;

  DeleteTransactionUseCase({required this.debtRepository});

  Future<void> call(int transactionId) {
    return debtRepository.deleteTransactionFromId(transactionId);
  }
}
