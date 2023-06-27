import '../models/debt_model.dart';
import '../models/transactions_model.dart';

abstract class DebtLocalDataSource {
  Future<void> addDebtOrCredit(DebtModel debt);

  DebtModel? fetchDebtOrCreditFromId(int debtId);

  Future<void> updateDebt(DebtModel debtModel);

  Iterable<TransactionsModel> getTransactionsFromId(int? id);

  Future<void> deleteDebtOrCreditFromId(int debtId);

  Future<void> addTransaction(TransactionsModel transactionsModel);

  Future<void> deleteTransactionsFromId(int parentId);

  Future<void> deleteTransactionFromId(int transactionId);
}
