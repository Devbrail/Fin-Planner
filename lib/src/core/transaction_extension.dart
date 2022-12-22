import 'package:flutter_paisa/src/data/debt/models/transaction.dart';
import 'package:hive_flutter/adapters.dart';

extension TransactionMapping on Box<Transaction> {
  List<Transaction> getTransactionsFromId(int? id) {
    if (id == null) {
      return [];
    } else {
      return values.where((element) => element.parentId == id).toList();
    }
  }
}
