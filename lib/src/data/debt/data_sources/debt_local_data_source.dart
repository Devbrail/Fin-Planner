import '../models/debt.dart';
import '../models/transaction.dart';

abstract class DebtLocalDataSource {
  Future<void> addDebtOrCredit(Debt debt);
  List<Transaction> getTransactionsFromId(int? id);
  Future<Debt?> fetchDebtOrCreditFromId(int debtId);
}
