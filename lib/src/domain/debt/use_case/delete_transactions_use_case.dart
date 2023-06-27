import 'package:injectable/injectable.dart';

import '../repository/debit_repository.dart';

@singleton
class DeleteTransactionsUseCase {
  DeleteTransactionsUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  Future<void> call(int debtId) {
    return debtRepository.deleteTransactionsFromId(debtId);
  }
}
