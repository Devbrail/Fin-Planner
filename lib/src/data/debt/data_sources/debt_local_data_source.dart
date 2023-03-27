import '../models/debt_model.dart';
import '../models/transactions_model.dart';

abstract class DebtLocalDataSource {
  Future<void> addDebtOrCredit(DebtModel debt);
  DebtModel? fetchDebtOrCreditFromId(int debtId);
  Future<void> updateDebt(DebtModel debtModel);
  List<TransactionsModel> getTransactionsFromId(int? id);
  Future<void> addTransaction(TransactionsModel transactionsModel);
}
