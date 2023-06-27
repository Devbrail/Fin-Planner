import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt_model.dart';
import '../../../data/debt/models/transactions_model.dart';

abstract class DebtRepository {
  Future<void> addDebtOrCredit(
    String description,
    String name,
    double amount,
    DateTime currentDateTime,
    DateTime dueDateTime,
    DebtType debtType,
  );

  Future<void> updateDebt({
    required String description,
    required String name,
    required double amount,
    required DateTime currentDateTime,
    required DateTime dueDateTime,
    required DebtType debtType,
    required int key,
  });

  DebtModel? fetchDebtOrCreditFromId(int debtId);

  Future<void> deleteDebtOrCreditFromId(int debtId);

  Future<void> deleteTransactionsFromId(int parentId);

  Future<void> deleteTransactionFromId(int transactionId);

  Future<void> addTransaction(
    double amount,
    DateTime currentDateTime,
    int parentId,
  );

  Iterable<TransactionsModel> fetchTransactionsFromId(int id);
}
