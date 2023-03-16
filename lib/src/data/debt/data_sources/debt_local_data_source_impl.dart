import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../models/debt_model.dart';
import '../models/transactions_model.dart';
import 'debt_local_data_source.dart';

@Singleton(as: DebtLocalDataSource)
class DebtLocalDataSourceImpl extends DebtLocalDataSource {
  final Box<DebtModel> debtBox;
  final Box<TransactionsModel> transactionsBox;

  DebtLocalDataSourceImpl({
    required this.debtBox,
    required this.transactionsBox,
  });

  @override
  Future<void> addDebtOrCredit(DebtModel debt) async {
    final int id = await debtBox.add(debt);
    debt.superId = id;
    await debt.save();
  }

  @override
  Future<DebtModel?> fetchDebtOrCreditFromId(int debtId) async =>
      debtBox.get(debtId);

  @override
  List<TransactionsModel> getTransactionsFromId(int? id) {
    if (id == null) return [];
    return transactionsBox.values
        .where((element) => element.parentId == id)
        .toList();
  }
}
