import '../../data/debt/models/debt_model.dart';
import '../../domain/debt/entities/debt.dart';

extension AccountMapping on DebtModel {
  Debt toEntity() => Debt(
        description: description,
        name: name,
        amount: amount,
        dateTime: dateTime,
        expiryDateTime: expiryDateTime,
        debtType: debtType,
        superId: superId,
      );
}
