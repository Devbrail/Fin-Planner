import 'package:injectable/injectable.dart';

import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt_model.dart';
import '../repository/debit_repository.dart';

@singleton
class DebtUseCase {
  final DebtRepository debtRepository;

  DebtUseCase({required this.debtRepository});

  Future<void> call({
    required String description,
    required String name,
    required double amount,
    required DateTime currentDateTime,
    required DateTime dueDateTime,
    required DebtType debtType,
  }) =>
      debtRepository.addDebtOrCredit(
        description,
        name,
        amount,
        currentDateTime,
        dueDateTime,
        debtType,
      );

  Future<DebtModel?> fetchDebtOrCreditFromId(int debtId) =>
      debtRepository.fetchDebtOrCreditFromId(debtId);
}
