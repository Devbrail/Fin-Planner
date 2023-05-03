import 'package:flutter/material.dart';

import '../model/expense_model.dart';

abstract class LocalExpenseDataManager {
  Future<void> addOrUpdateExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> filteredExpenses(DateTimeRange dateTimeRange);
  Future<void> clearExpenses();
  Future<void> clearExpense(int key);
  ExpenseModel? fetchExpenseFromId(int expenseId);
  Iterable<ExpenseModel> exportData();
  List<ExpenseModel> expenses();
  Future<void> deleteExpensesByAccountId(int accountId);
  Future<void> deleteExpensesByCategoryId(int categoryId);
  List<ExpenseModel> fetchExpensesFromAccountId(int accountId);
  List<ExpenseModel> fetchExpensesFromCategoryId(int category);
  Future<void> updateExpense(ExpenseModel expenseModel);
  Future<void> clearAll();
  List<ExpenseModel> filterExpenses(
      String query, int? accountId, int? categoryId);
}
