import '../model/expense.dart';

abstract class ExpenseManagerDataSource {
  Future<void> addOrUpdateExpense(Expense expense);
  Future<List<Expense>> expenses();
  Future<void> clearExpenses();
  Future<void> clearExpense(int key);
}
