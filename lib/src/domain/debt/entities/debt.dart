import 'package:paisa/src/data/debt/models/debt_model.dart';

class Debt extends DebtModel {
  Debt({
    required super.description,
    required super.name,
    required super.amount,
    required super.dateTime,
    required super.expiryDateTime,
    required super.debtType,
    super.superId,
  });
}
