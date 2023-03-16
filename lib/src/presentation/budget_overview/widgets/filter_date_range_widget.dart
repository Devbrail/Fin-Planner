import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../domain/expense/entities/expense.dart';

class FilterDateRangeWidget extends StatelessWidget {
  const FilterDateRangeWidget({
    super.key,
    required this.builder,
    required this.expenses,
    required this.dateTimeRangeNotifier,
  });
  final Iterable<Expense> expenses;
  final Widget Function(List<Expense> expenses) builder;
  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTimeRange?>(
      valueListenable: dateTimeRangeNotifier,
      builder: (context, value, child) {
        if (value != null) {
          return builder.call(expenses.isFilterTimeBetween(value));
        } else {
          return builder.call(expenses.toList());
        }
      },
    );
  }
}
