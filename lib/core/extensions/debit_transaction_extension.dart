import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/features/debit/data/models/debit_transactions_model.dart';
import 'package:paisa/features/debit/domain/entities/debit_transaction.dart';

extension DebitTransactionModelBoxHelper on Box<DebitTransactionsModel> {
  List<DebitTransaction> getTransactionsFromId(int parentId) {
    return values
        .where((DebitTransactionsModel element) => element.parentId == parentId)
        .toEntities();
  }
}

extension DebitTransactionModelHelper on DebitTransactionsModel {
  DebitTransaction toEntity() => DebitTransaction(
        amount: amount,
        now: now,
        parentId: parentId,
      );
}

extension DebitTransactionModelsHelper on Iterable<DebitTransactionsModel> {
  List<DebitTransaction> toEntities() =>
      map((DebitTransactionsModel e) => e.toEntity())
          .sorted((DebitTransaction a, DebitTransaction b) =>
              b.now.compareTo(a.now))
          .toList();
}
