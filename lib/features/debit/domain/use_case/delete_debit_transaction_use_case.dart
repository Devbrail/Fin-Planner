import 'package:injectable/injectable.dart';

import '../repository/debit_repository.dart';

@singleton
class DeleteTransactionUseCase {
  DeleteTransactionUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  Future<void> call(int transactionId) {
    return debtRepository.deleteTransactionFromId(transactionId);
  }
}
