import '../../../common/enum/filter_days.dart';
import '../../../common/enum/transaction.dart';
import '../../../data/expense/model/expense.dart';

abstract class ExpenseRepository {
  Future<Map<String, List<Expense>>> expenses(bool isRefresh);
  Future<String> totalExpenses(TransactonType type);
  Future<String> filterExpensesTotal(FilterDays filterDays);
  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactonType transactonType,
  );
  Future<void> clearExpenses();
  Future<void> clearExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
}
