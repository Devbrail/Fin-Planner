import 'package:hive_flutter/adapters.dart';

import '../data/debt/models/transaction.dart';

extension TransactionMapping on Box<Transaction> {
  List<Transaction> getTransactionsFromId(int? id) {
    if (id == null) return [];
    return values.where((element) => element.parentId == id).toList();
  }
}
