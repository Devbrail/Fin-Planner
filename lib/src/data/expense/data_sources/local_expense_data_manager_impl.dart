import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../model/expense_model.dart';
import 'local_expense_data_manager.dart';

@Injectable(as: LocalExpenseDataManager)
class LocalExpenseDataManagerImpl implements LocalExpenseDataManager {
  final Box<ExpenseModel> expenseBox;

  LocalExpenseDataManagerImpl(this.expenseBox);

  @override
  List<ExpenseModel> expenses() => expenseBox.values.toList();

  @override
  Future<void> addOrUpdateExpense(ExpenseModel expense) async {
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
  Future<List<ExpenseModel>> filteredExpenses(
      DateTimeRange dateTimeRange) async {
    final List<ExpenseModel> expenses = expenseBox.values.toList();
    expenses.sort((a, b) => b.time.compareTo(a.time));
    final filteredExpenses = expenses.takeWhile((value) {
      return value.time.isAfter(dateTimeRange.start) &&
          value.time.isBefore(dateTimeRange.end);
    }).toList();
    return filteredExpenses;
  }

  @override
  ExpenseModel? fetchExpenseFromId(int expenseId) =>
      expenseBox.values.firstWhereOrNull((element) => element.key == expenseId);

  @override
  Iterable<ExpenseModel> exportData() => expenseBox.values;

  @override
  Future<void> deleteExpensesByAccountId(int accountId) {
    final keys = expenseBox.values
        .where((element) => element.accountId == accountId)
        .map((e) => e.key);
    return expenseBox.deleteAll(keys);
  }

  @override
  Future<void> deleteExpensesByCategoryId(int categoryId) {
    final keys = expenseBox.values
        .where((element) => element.categoryId == categoryId)
        .map((e) => e.key);
    return expenseBox.deleteAll(keys);
  }

  @override
  List<ExpenseModel> fetchExpensesFromAccountId(int accountId) =>
      expenseBox.values
          .where((element) => element.accountId == accountId)
          .toList();

  @override
  List<ExpenseModel> fetchExpensesFromCategoryId(int category) =>
      expenseBox.values
          .where((element) => element.categoryId == category)
          .toList();
}
