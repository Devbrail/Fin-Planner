import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt_model.dart';

abstract class DebtRepository {
  Future<void> addDebtOrCredit(
    String description,
    String name,
    double amount,
    DateTime currentDateTime,
    DateTime dueDateTime,
    DebtType debtType,
  );

  Future<DebtModel?> fetchDebtOrCreditFromId(int debtId);
}
