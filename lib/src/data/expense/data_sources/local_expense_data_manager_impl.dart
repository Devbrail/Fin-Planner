import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../core/common.dart';

import '../model/expense_model.dart';
import 'local_expense_data_manager.dart';

@Injectable(as: ExpenseLocalDataManager)
class LocalExpenseDataManagerImpl implements ExpenseLocalDataManager {
  LocalExpenseDataManagerImpl(this.expenseBox);

  final Box<ExpenseModel> expenseBox;

  @override
  Future<void> add(ExpenseModel expense) async {
    final id = await expenseBox.add(expense);
    expense.superId = id;
    return expense.save();
  }

  @override
  Future<void> clear() => expenseBox.clear();

  @override
  Future<void> deleteById(int key) {
    return expenseBox.delete(key);
  }

  @override
  Future<void> deleteByAccountId(int accountId) {
    final keys = expenseBox.values
        .where((element) => element.accountId == accountId)
        .map((e) => e.key);
    return expenseBox.deleteAll(keys);
  }

  @override
  Future<void> deleteByCategoryId(int categoryId) {
    final keys = expenseBox.values
        .where((element) => element.categoryId == categoryId)
        .map((e) => e.key);
    return expenseBox.deleteAll(keys);
  }

  @override
  List<ExpenseModel> expenses() => expenseBox.values.toList();

  @override
  Iterable<ExpenseModel> export() => expenseBox.values;

  @override
  ExpenseModel? findById(int expenseId) =>
      expenseBox.values.firstWhereOrNull((element) => element.key == expenseId);

  @override
  List<ExpenseModel> findByAccountId(int accountId) => expenseBox.values
      .where((element) => element.accountId != -1 && element.categoryId != -1)
      .where((element) => element.accountId == accountId)
      .toList();

  @override
  List<ExpenseModel> findByCategoryId(int category) => expenseBox.values
      .where((element) => element.accountId != -1 && element.categoryId != -1)
      .where((element) => element.categoryId == category)
      .toList();

  @override
  List<ExpenseModel> filterExpenses(
    String query,
    int? accountId,
    int? categoryId,
  ) {
    return expenseBox.search(
      query,
      selectedAccountId: accountId,
      selectedCategoryId: categoryId,
    );
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
  Future<void> update(ExpenseModel expenseModel) {
    return expenseBox.put(expenseModel.superId!, expenseModel);
  }
}
