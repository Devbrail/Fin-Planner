import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_expense.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/paisa_empty_widget.dart';
import 'expense_month_card.dart';

class ExpenseHistoryWidget extends StatelessWidget {
  const ExpenseHistoryWidget({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return EmptyWidget(
        title: context.loc.emptyExpensesMessageTitle,
        icon: Icons.money_off_rounded,
        description: context.loc.emptyExpensesMessageSubTitle,
      );
    } else {
      final maps = groupBy(expenses,
          (Expense element) => element.time.formatted(FilterExpense.monthly));
      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: maps.entries.length,
        itemBuilder: (_, mapIndex) => ExpenseMonthCardWidget(
          title: maps.keys.elementAt(mapIndex),
          total: maps.values.elementAt(mapIndex).filterTotal,
          expenses: maps.values.elementAt(mapIndex),
        ),
      );
    }
  }
}
