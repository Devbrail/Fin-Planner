import '../models/transaction.dart';

import '../models/debt.dart';

abstract class DebtLocalDataSource {
  Future<void> addDebtOrCredit(Debt debt);
  List<Transaction> getTransactionsFromId(int? id);
  Future<Debt?> fetchDebtOrCreditFromId(int debtId);
}
