import '../../../core/enum/transaction_type.dart';
import '../../../data/expense/model/expense_model.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType transactionType,
    String? description,
    int? fromAccountId,
    int? toAccountId,
    double transferAmount,
  );

  Future<void> clearExpense(int expenseId);

  ExpenseModel? fetchExpenseFromId(int expenseId);

  List<ExpenseModel> expenses();

  List<ExpenseModel> fetchExpensesFromAccountId(int accountId);

  List<ExpenseModel> fetchExpensesFromCategoryId(int accountId);

  Future<void> deleteExpensesByAccountId(int accountId);

  Future<void> deleteExpensesByCategoryId(int categoryId);

  Future<void> updateExpense(
    int key,
    String name,
    double currency,
    DateTime time,
    int categoryId,
    int accountId,
    TransactionType transactionType,
    String? description,
  );

  Future<void> clearAll();

  List<ExpenseModel> filterExpenses(
      String query, int? accountId, int? categoryId);
}
