import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/expense/model/expense.dart';
import 'time.dart';

extension ExpenseListMapping on Box<Expense> {
  List<Expense> allAccount(int accountId) {
    return values.where((element) => element.accountId == accountId).toList();
  }

  List<Expense> isFilterTimeBetween(DateTimeRange range) {
    return values
        .where((element) => element.time.isAfterBeforeTime(range))
        .toList();
  }
}
