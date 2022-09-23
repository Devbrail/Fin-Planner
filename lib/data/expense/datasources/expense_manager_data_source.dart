import 'package:flutter/material.dart';

import '../model/expense.dart';

abstract class ExpenseManagerDataSource {
  Future<void> addOrUpdateExpense(Expense expense);
  Future<List<Expense>> expenses();
  Future<List<Expense>> filteredExpenses(DateTimeRange dateTimeRange);
  Future<void> clearExpenses();
  Future<void> clearExpense(int key);

  Future<Expense?> fetchExpenseFromId(int expenseId);
}
