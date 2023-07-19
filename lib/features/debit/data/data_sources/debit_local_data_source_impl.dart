import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../models/debit_model.dart';
import '../models/debit_transactions_model.dart';
import 'debit_local_data_source.dart';

@Singleton(as: DebtLocalDataSource)
class DebtLocalDataSourceImpl extends DebtLocalDataSource {
  DebtLocalDataSourceImpl({
    required this.debtBox,
    required this.transactionsBox,
  });

  final Box<DebitModel> debtBox;
  final Box<DebitTransactionsModel> transactionsBox;

  @override
  Future<void> addDebtOrCredit(DebitModel debt) async {
    final int id = await debtBox.add(debt);
    debt.superId = id;
    return debt.save();
  }

  @override
  Future<void> addTransaction(DebitTransactionsModel transactionsModel) async {
    final int id = await transactionsBox.add(transactionsModel);
    transactionsModel.superId = id;
    return transactionsModel.save();
  }

  @override
  Future<void> deleteDebtOrCreditFromId(int debtId) {
    return debtBox.delete(debtId);
  }

  @override
  Future<void> deleteTransactionFromId(int transactionId) {
    return transactionsBox.delete(transactionId);
  }

  @override
  Future<void> deleteTransactionsFromId(int parentId) {
    final Iterable<int> transactionsKeys = transactionsBox.values
        .where((element) => element.parentId == parentId)
        .map((e) => e.superId!);
    return transactionsBox.deleteAll(transactionsKeys);
  }

  @override
  DebitModel? fetchDebtOrCreditFromId(int debtId) =>
      debtBox.values.firstWhereOrNull((element) => element.superId == debtId);

  @override
  Iterable<DebitTransactionsModel> getTransactionsFromId(int? id) {
    return transactionsBox.values.where((element) => element.parentId == id);
  }

  @override
  Future<void> updateDebt(DebitModel debtModel) {
    return debtBox.put(debtModel.superId!, debtModel);
  }
}
