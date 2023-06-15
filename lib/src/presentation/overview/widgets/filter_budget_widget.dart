import 'package:flutter/material.dart';
import 'package:paisa/src/data/expense/model/expense_model.dart';

import '../../../core/common.dart';
import '../../../domain/expense/entities/expense.dart';
import '../pages/overview_page.dart';

class FilterOverviewWidget extends StatelessWidget {
  const FilterOverviewWidget({
    super.key,
    required this.valueNotifier,
    required this.builder,
    required this.expenses,
  });
  final Iterable<ExpenseModel> expenses;
  final ValueNotifier<OverviewType> valueNotifier;
  final Widget Function(List<Expense> expenses) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<OverviewType>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return builder.call(expenses.budgetOverView(value).toEntities());
      },
    );
  }
}
