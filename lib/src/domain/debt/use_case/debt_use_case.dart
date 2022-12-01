import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt.dart';
import '../repository/debit_repository.dart';

class DebtUseCase {
  final DebtRepository debtRepository;

  DebtUseCase({required this.debtRepository});

  Future<void> addDebtOrCredit({
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

  Future<Debt?> fetchDebtOrCreditFromId(int debtId) =>
      debtRepository.fetchDebtOrCreditFromId(debtId);
}
