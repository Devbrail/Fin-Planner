import '../../../core/enum/transaction.dart';
import '../../../data/expense/model/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType transactionType,
    String? description,
  );
  Future<void> clearExpense(int expenseId);

  Future<Expense?> fetchExpenseFromId(int expenseId);
}
