import '../models/debit_model.dart';
import '../models/debit_transactions_model.dart';

abstract class DebtLocalDataSource {
  Future<void> addDebtOrCredit(DebitModel debt);

  DebitModel? fetchDebtOrCreditFromId(int debtId);

  Future<void> updateDebt(DebitModel debtModel);

  Iterable<DebitTransactionsModel> getTransactionsFromId(int? id);

  Future<void> deleteDebtOrCreditFromId(int debtId);

  Future<void> addTransaction(DebitTransactionsModel transactionsModel);

  Future<void> deleteTransactionsFromId(int parentId);

  Future<void> deleteTransactionFromId(int transactionId);
}
