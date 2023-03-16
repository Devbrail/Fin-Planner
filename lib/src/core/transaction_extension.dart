import 'package:hive_flutter/adapters.dart';

import '../data/debt/models/transactions_model.dart';

extension TransactionMapping on Box<TransactionsModel> {
  List<TransactionsModel> getTransactionsFromId(int? id) {
    if (id == null) return [];
    return values.where((element) => element.parentId == id).toList();
  }
}
