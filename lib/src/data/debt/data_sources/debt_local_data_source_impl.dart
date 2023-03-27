import 'package:collection/collection.dart';
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
    return debt.save();
  }

  @override
  DebtModel? fetchDebtOrCreditFromId(int debtId) =>
      debtBox.values.firstWhereOrNull((element) => element.superId == debtId);

  @override
  List<TransactionsModel> getTransactionsFromId(int? id) {
    return transactionsBox.values
        .where((element) => element.parentId == id)
        .toList();
  }

  @override
  Future<void> addTransaction(TransactionsModel transactionsModel) async {
    final int id = await transactionsBox.add(transactionsModel);
    transactionsModel.superId = id;
    return transactionsModel.save();
  }

  @override
  Future<void> updateDebt(DebtModel debtModel) {
    return debtBox.put(debtModel.superId!, debtModel);
  }
}
