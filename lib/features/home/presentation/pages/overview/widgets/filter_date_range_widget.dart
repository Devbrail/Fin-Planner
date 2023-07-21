import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';

class FilterDateRangeWidget extends StatelessWidget {
  const FilterDateRangeWidget({
    super.key,
    required this.builder,
    required this.expenses,
    required this.dateTimeRangeNotifier,
  });

  final Widget Function(List<TransactionEntity> expenses) builder;
  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier;
  final Iterable<TransactionEntity> expenses;

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
