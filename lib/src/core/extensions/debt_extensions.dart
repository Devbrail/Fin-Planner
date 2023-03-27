import 'package:collection/collection.dart';
import 'package:paisa/src/data/debt/models/debt_model.dart';
import 'package:paisa/src/data/debt/models/transactions_model.dart';
import 'package:paisa/src/domain/debt/entities/debt.dart';
import 'package:paisa/src/domain/debt/entities/transaction.dart';

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

extension MappingOnTransaction on TransactionsModel {
  Transaction toEntity() => Transaction(
        amount: amount,
        now: now,
        parentId: parentId,
      );
}

extension MappingOnTransactions on List<TransactionsModel> {
  List<Transaction> toEntities() => map((e) => e.toEntity())
      .sorted((a, b) => a.now.compareTo(b.now))
      .toList();
}
