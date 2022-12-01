import 'package:flutter/material.dart';

import '../model/expense.dart';

abstract class LocalExpenseManagerDataSource {
  Future<void> addOrUpdateExpense(Expense expense);
  Future<List<Expense>> filteredExpenses(DateTimeRange dateTimeRange);
  Future<void> clearExpenses();
  Future<void> clearExpense(int key);
  Future<Expense?> fetchExpenseFromId(int expenseId);
  Future<Iterable<Expense>> exportData();
}
