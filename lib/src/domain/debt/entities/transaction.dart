import 'package:paisa/src/data/debt/models/transactions_model.dart';

class Transaction extends TransactionsModel {
  Transaction({
    required super.amount,
    required super.now,
    required super.parentId,
    super.superId,
  });
}
