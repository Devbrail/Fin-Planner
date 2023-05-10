import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_expense.dart';
import '../../../domain/expense/entities/expense.dart';

class FilterBudgetWidget extends StatelessWidget {
  const FilterBudgetWidget({
    super.key,
    required this.valueNotifier,
    required this.builder,
    required this.expenses,
  });
  final Iterable<Expense> expenses;
  final ValueNotifier<FilterExpense> valueNotifier;
  final Widget Function(
    List<MapEntry<String, List<Expense>>> filteredBudger,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterExpense>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return builder.call(expenses.groupByTime(value));
      },
    );
  }
}
