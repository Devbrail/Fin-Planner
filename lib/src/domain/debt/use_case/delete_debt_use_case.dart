import 'package:injectable/injectable.dart';

import '../repository/debit_repository.dart';

@singleton
class DeleteDebtUseCase {
  final DebtRepository debtRepository;

  DeleteDebtUseCase({required this.debtRepository});

  Future<void> call(int debtId) {
    return debtRepository.deleteDebtOrCreditFromId(debtId);
  }
}
