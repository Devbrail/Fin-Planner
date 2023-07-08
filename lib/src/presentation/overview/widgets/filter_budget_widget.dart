import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../core/enum/transaction_type.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/expense/entities/expense.dart';

class FilterOverviewWidget extends StatelessWidget {
  const FilterOverviewWidget({
    super.key,
    required this.valueNotifier,
    required this.builder,
    required this.expenses,
  });

  final Widget Function(List<Expense> expenses) builder;
  final Iterable<ExpenseModel> expenses;
  final ValueNotifier<TransactionType> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TransactionType>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return builder.call(expenses.budgetOverView(value));
      },
    );
  }
}
