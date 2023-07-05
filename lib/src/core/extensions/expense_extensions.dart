import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/expense/model/expense_model.dart';
import '../../domain/expense/entities/expense.dart';
import '../common.dart';
import '../enum/filter_expense.dart';
import '../enum/transaction_type.dart';

extension ExpenseModelBoxMapping on Box<ExpenseModel> {
  List<ExpenseModel> get expenses =>
      values.sorted(((a, b) => b.time.compareTo(a.time)));

  List<ExpenseModel> expensesFromAccountId(int accountId) =>
      expenses.where((element) => element.accountId == accountId).toList();

  List<Expense> get toEntities => values
      .map((expenseModel) => expenseModel.toEntity())
      .sorted((a, b) => b.time.compareTo(a.time));

  List<ExpenseModel> isFilterTimeBetween(DateTimeRange range) =>
      values.where((element) => element.time.isAfterBeforeTime(range)).toList();

  Iterable<ExpenseModel> get expenseList =>
      values.where((element) => element.type == TransactionType.expense);

  Iterable<ExpenseModel> get incomeList =>
      values.where((element) => element.type == TransactionType.income);

  double get totalExpense => expenseList
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);

  double get totalIncome => incomeList
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);

  List<Expense> search(
    query, {
    int? selectedAccountId = -1,
    int? selectedCategoryId = -1,
  }) {
    Iterable<ExpenseModel> expenseModels = values;
    if (selectedAccountId != -1) {
      expenseModels =
          values.where((element) => element.accountId == selectedAccountId);
    }
    if (selectedCategoryId != -1) {
      expenseModels =
          values.where((element) => element.categoryId == selectedCategoryId);
    }

    return expenseModels.where((ExpenseModel element) {
      final description = element.description ?? '';
      return element.name.toLowerCase().contains(query) ||
          description.toLowerCase().contains(query);
    }).toEntities();
  }
}

extension ExpenseModelHelper on ExpenseModel {
  Expense toEntity() => Expense(
        name: name,
        currency: currency,
        time: time,
        categoryId: categoryId,
        accountId: accountId,
        type: type,
        description: description,
        fromAccountId: fromAccountId,
        superId: superId,
        toAccountId: toAccountId,
        transferAmount: transferAmount,
      );
}

extension ExpenseModelsHelper on Iterable<ExpenseModel> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  List<Expense> toEntities() {
    return map((expenseModel) => expenseModel.toEntity())
        .sorted((a, b) => b.time.compareTo(a.time));
  }

  List<Expense> budgetOverView(TransactionType transactionType) =>
      sorted((a, b) => b.time.compareTo(a.time))
          .where((element) => element.type == transactionType)
          .toEntities();
}

extension ExpensesHelper on Iterable<Expense> {
  List<Expense> get expenses => sorted(((a, b) => b.time.compareTo(a.time)));

  List<Expense> get expenseList =>
      where((element) => element.type == TransactionType.expense).toList();

  List<Expense> get incomeList =>
      where((element) => element.type == TransactionType.income).toList();

  List<Expense> isFilterTimeBetween(DateTimeRange range) =>
      where((element) => element.time.isAfterBeforeTime(range)).toList();

  double get filterTotal => fold<double>(0, (previousValue, element) {
        if (element.type == TransactionType.expense) {
          return previousValue - element.currency;
        } else if (element.type == TransactionType.income) {
          return previousValue + element.currency;
        } else {
          return previousValue;
        }
      });
  double get fullTotal => totalIncome - totalExpense;

  double get totalExpense => expenseList
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);

  double get totalIncome => incomeList
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);

  double get total => map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);

  double get thisMonthExpense =>
      where((element) => element.type == TransactionType.expense)
          .where((element) =>
              element.time.month == DateTime.now().month &&
              element.time.year == DateTime.now().year)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  List<Expense> get thisMonthExpensesList =>
      where((element) => element.type == TransactionType.expense)
          .where((element) =>
              element.time.month == DateTime.now().month &&
              element.time.year == DateTime.now().year)
          .toList();
  List<double> get expenseDoubleList =>
      thisMonthExpensesList.map((element) => element.currency).toList();

  List<Expense> get thisMonthIncomeList =>
      where((element) => element.type == TransactionType.income)
          .where((element) =>
              element.time.month == DateTime.now().month &&
              element.time.year == DateTime.now().year)
          .toList();

  List<double> get incomeDoubleList =>
      thisMonthIncomeList.map((element) => element.currency).toList();

  double get thisMonthIncome =>
      where((element) => element.type == TransactionType.income)
          .where((element) =>
              element.time.month == DateTime.now().month &&
              element.time.year == DateTime.now().year)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  List<MapEntry<String, List<Expense>>> groupByTime(
          FilterExpense filterBudget) =>
      groupBy(this,
              (ExpenseModel element) => element.time.formatted(filterBudget))
          .entries
          .toList();

  Map<String, List<Expense>> groupByTimeList(FilterExpense filterBudget) =>
      groupBy(
          this, (ExpenseModel element) => element.time.formatted(filterBudget));

  List<Expense> toEntities() =>
      map((expenseModel) => expenseModel.toEntity()).toList();
}

extension ExpenseHelper on Expense {}
