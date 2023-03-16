import '../models/debt_model.dart';
import '../models/transactions_model.dart';

abstract class DebtLocalDataSource {
  Future<void> addDebtOrCredit(DebtModel debt);
  List<TransactionsModel> getTransactionsFromId(int? id);
  Future<DebtModel?> fetchDebtOrCreditFromId(int debtId);
}
