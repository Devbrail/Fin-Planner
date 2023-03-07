import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../models/debt.dart';
import '../models/transaction.dart';
import 'debt_local_data_source.dart';

@LazySingleton(as: DebtLocalDataSource)
class DebtLocalDataSourceImpl extends DebtLocalDataSource {
  final Box<Debt> debtBox;
  final Box<Transaction> transactionsBox;

  DebtLocalDataSourceImpl({
    required this.debtBox,
    required this.transactionsBox,
  });

  @override
  Future<void> addDebtOrCredit(Debt debt) async {
    final int id = await debtBox.add(debt);
    debt.superId = id;
    await debt.save();
  }

  @override
  Future<Debt?> fetchDebtOrCreditFromId(int debtId) async =>
      debtBox.get(debtId);

  @override
  List<Transaction> getTransactionsFromId(int? id) {
    if (id == null) return [];
    return transactionsBox.values
        .where((element) => element.parentId == id)
        .toList();
  }
}
