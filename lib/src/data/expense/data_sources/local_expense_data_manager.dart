import 'package:flutter/material.dart';

import '../model/expense_model.dart';

abstract class ExpenseLocalDataManager {
  Future<void> add(ExpenseModel expense);

  Future<List<ExpenseModel>> filteredExpenses(DateTimeRange dateTimeRange);

  Future<void> deleteById(int key);

  ExpenseModel? findById(int expenseId);

  Iterable<ExpenseModel> export();

  List<ExpenseModel> expenses();

  Future<void> deleteByAccountId(int accountId);

  Future<void> deleteByCategoryId(int categoryId);

  List<ExpenseModel> findByAccountId(int accountId);

  List<ExpenseModel> findByCategoryId(int category);

  Future<void> update(ExpenseModel expenseModel);

  Future<void> clear();

  List<ExpenseModel> filterExpenses(
      String query, int? accountId, int? categoryId);
}
