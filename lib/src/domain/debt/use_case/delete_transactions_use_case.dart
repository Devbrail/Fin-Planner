import 'package:injectable/injectable.dart';

import '../repository/debit_repository.dart';

@singleton
class DeleteTransactionsUseCase {
  final DebtRepository debtRepository;

  DeleteTransactionsUseCase({required this.debtRepository});

  Future<void> call(int debtId) {
    return debtRepository.deleteTransactionsFromId(debtId);
  }
}
