import '../../../common/enum/filter_days.dart';
import '../../../common/enum/transaction.dart';
import '../../../data/expense/model/expense.dart';

abstract class ExpenseRepository {
  Future<Map<String, List<Expense>>> expenses(bool isRefresh);
  Future<String> totalExpenses(TransactionType type);
  Future<String> filterExpensesTotal(FilterDays filterDays);
  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType transactionType,
  );
  Future<void> clearExpenses();
  Future<void> clearExpense(int expenseId);
  Future<void> updateExpense(Expense expense);

  Future<Expense?> fetchExpenseFromId(int expenseId);
}
