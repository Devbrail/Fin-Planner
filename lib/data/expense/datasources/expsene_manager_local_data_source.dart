import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../model/expense.dart';
import 'expense_manager_data_source.dart';

class ExpenseManagerLocalDataSource implements ExpenseManagerDataSource {
  late final epenseBox = Hive.box<Expense>(BoxType.expense.stringValue);
  @override
  Future<void> addOrUpdateExpense(Expense expense) async {
    final id = await epenseBox.add(expense);
    expense.superId = id;
    expense.save();
  }

  @override
  Future<List<Expense>> expenses() async {
    return epenseBox.values.toList();
  }

  @override
  Future<void> clearExpenses() async {
    await epenseBox.clear();
  }

  @override
  Future<void> clearExpense(int key) async {
    await epenseBox.delete(key);
  }

  @override
  Future<List<Expense>> filteredExpenses(DateTimeRange dateTimeRange) async {
    final List<Expense> expenses = epenseBox.values.toList();
    expenses.sort((a, b) => b.time.compareTo(a.time));
    final filteredExpenses = expenses.takeWhile((value) {
      return value.time.isAfter(dateTimeRange.start) &&
          value.time.isBefore(dateTimeRange.end);
    }).toList();
    return filteredExpenses;
  }
}
