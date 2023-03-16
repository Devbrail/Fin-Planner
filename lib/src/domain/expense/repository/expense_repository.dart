import '../../../core/enum/transaction.dart';
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
  );
  Future<void> clearExpense(int expenseId);
  ExpenseModel? fetchExpenseFromId(int expenseId);
  List<ExpenseModel> expenses();
  List<ExpenseModel> fetchExpensesFromAccountId(int accountId);
  List<ExpenseModel> fetchExpensesFromCategoryId(int accountId);
  Future<void> deleteExpensesByAccountId(int accountId);
  Future<void> deleteExpensesByCategoryId(int categoryId);
}
