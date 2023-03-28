import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/debt/models/transactions_model.dart';
import '../../domain/debt/entities/transaction.dart';

extension MappingOnTransactionsBox on Box<TransactionsModel> {
  List<Transaction> getTransactionsFromId(int parentId) {
    return values.where((element) => element.parentId == parentId).toEntities();
  }
}

extension MappingOnTransaction on TransactionsModel {
  Transaction toEntity() => Transaction(
        amount: amount,
        now: now,
        parentId: parentId,
      );
}

extension MappingOnTransactions on Iterable<TransactionsModel> {
  List<Transaction> toEntities() => map((e) => e.toEntity())
      .sorted((a, b) => b.now.compareTo(a.now))
      .toList();
}
