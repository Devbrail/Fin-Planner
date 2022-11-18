import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/expense/model/expense.dart';
import '../common.dart';
import '../enum/filter_budget.dart';
import '../enum/transaction.dart';

extension ExpenseListMapping on Box<Expense> {
  List<Expense> allAccount(int accountId) {
    return values.where((element) => element.accountId == accountId).toList();
  }

  List<Expense> get budgetOverView {
    final list = values
        .where((element) => element.type != TransactionType.income)
        .toList();
    list.sort((a, b) => a.time.compareTo(b.time));
    return list;
  }

  List<Expense> isFilterTimeBetween(DateTimeRange range) {
    return values
        .where((element) => element.time.isAfterBeforeTime(range))
        .toList();
  }
}

extension TotalAmountOnExpenses on Iterable<Expense> {
  List<Expense> get expenseList =>
      where((element) => element.type == TransactionType.expense).toList();

  List<Expense> get incomeList =>
      where((element) => element.type == TransactionType.income).toList();

  String get balance => formattedCurrency(totalIncome - totalExpense);

  List<Expense> isFilterTimeBetween(DateTimeRange range) {
    return where((element) => element.time.isAfterBeforeTime(range)).toList();
  }

  double get filterTotal => fold<double>(0, (previousValue, element) {
        if (element.type == TransactionType.expense) {
          return previousValue - element.currency;
        } else {
          return previousValue + element.currency;
        }
      });

  double get totalExpense =>
      where((element) => element.type == TransactionType.expense)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  double get totalIncome =>
      where((element) => element.type == TransactionType.income)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  double get total => map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);

  String get totalWithCurrencySymbol => formattedCurrency(total);

  double get thisMonthExpense =>
      where((element) => element.type == TransactionType.expense)
          .where((element) => element.time.month == DateTime.now().month)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  double get thisMonthIncome =>
      where((element) => element.type == TransactionType.income)
          .where((element) => element.time.month == DateTime.now().month)
          .map((e) => e.currency)
          .fold<double>(0, (previousValue, element) => previousValue + element);

  List<MapEntry<String, List<Expense>>> groupByTime(FilterBudget filterBudget) {
    return groupBy(
            this, (Expense element) => element.time.formatted(filterBudget))
        .entries
        .toList();
  }
}
