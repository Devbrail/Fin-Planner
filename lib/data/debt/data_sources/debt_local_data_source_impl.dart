import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../models/debt.dart';
import '../models/transaction.dart';
import 'debt_local_data_source.dart';

class DebtLocalDataSourceImpl extends DebtLocalDataSource {
  late final debtBox = Hive.box<Debt>(BoxType.debts.stringValue);
  late final transactionsBox =
      Hive.box<Transaction>(BoxType.transactions.stringValue);
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
