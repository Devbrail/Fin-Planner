import '../../../common/enum/filter_days.dart';
import '../../../common/enum/transaction.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';

abstract class ExpenseRepository {
  Future<Map<String, List<Expense>>> expenses(bool isRefresh);
  Future<Map<Category, List<Expense>>> fetchBudgetSummary();
  Future<Map<Account, List<Expense>>> fetchAccountsSummary();
  Future<String> totalExpenses(TransactonType type);
  Future<String> filterExpensesTotal(FilterDays filterDays);
  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    Category category,
    Account account,
    TransactonType transactonType,
  );
  Future<void> clearExpenses();
  Future<void> clearExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
}
