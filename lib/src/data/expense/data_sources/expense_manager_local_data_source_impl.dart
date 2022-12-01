import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/expense.dart';
import 'expense_manager_local_data_source.dart';

class LocalExpenseManagerDataSourceImpl
    implements LocalExpenseManagerDataSource {
  final Box<Expense> expenseBox;

  LocalExpenseManagerDataSourceImpl(this.expenseBox);

  Stream<BoxEvent> expenses() {
    return expenseBox.watch();
  }

  @override
  Future<void> addOrUpdateExpense(Expense expense) async {
    final id = await expenseBox.add(expense);
    expense.superId = id;
    expense.save();
  }

  @override
  Future<void> clearExpenses() async {
    await expenseBox.clear();
  }

  @override
  Future<void> clearExpense(int key) async {
    await expenseBox.delete(key);
  }

  @override
  Future<List<Expense>> filteredExpenses(DateTimeRange dateTimeRange) async {
    final List<Expense> expenses = expenseBox.values.toList();
    expenses.sort((a, b) => b.time.compareTo(a.time));
    final filteredExpenses = expenses.takeWhile((value) {
      return value.time.isAfter(dateTimeRange.start) &&
          value.time.isBefore(dateTimeRange.end);
    }).toList();
    return filteredExpenses;
  }

  @override
  Future<Expense?> fetchExpenseFromId(int expenseId) async =>
      expenseBox.get(expenseId);

  @override
  Future<Iterable<Expense>> exportData() async => expenseBox.values;
}
