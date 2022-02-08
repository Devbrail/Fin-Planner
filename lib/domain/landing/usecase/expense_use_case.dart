import '../../../common/enum/filter_days.dart';
import '../../../common/enum/transaction.dart';
import '../../../data/expense/model/expense.dart';
import '../repository/expense_repository.dart';

class ExpenseUseCase {
  ExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<String> yesterdayTotal() {
    return expenseRepository.filterExpensesTotal(FilterDays.yesterday);
  }

  Future<String> lastSevenDaysExpenseTotal() {
    return expenseRepository.filterExpensesTotal(FilterDays.seven);
  }

  Future<String> lastThirtyDaysExpenseTotal() {
    return expenseRepository.filterExpensesTotal(FilterDays.thirty);
  }

  Future<Map<String, List<Expense>>> expenses(bool isRefresh) {
    return expenseRepository.expenses(isRefresh);
  }

  Future<String> totalTransactionType(TransactonType type) =>
      expenseRepository.totalExpenses(type);

  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactonType type,
  ) async {
    await expenseRepository.addExpense(
      name,
      amount,
      time,
      category,
      account,
      type,
    );
  }

  Future<void> clearExpenses() async {
    expenseRepository.clearExpenses();
  }

  Future<void> clearExpense(Expense expense) async {
    expenseRepository.clearExpense(expense);
  }

  Future<void> updateExpense(Expense expense) async {
    expenseRepository.updateExpense(expense);
  }
}
