import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../controller/summary_controller.dart';
import 'expense_month_card.dart';

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final SummaryController summaryController = getIt.get();
    if (expenses.isEmpty) {
      return EmptyWidget(
        title: context.loc.emptyExpensesMessage,
        icon: Icons.money_off_rounded,
        description: context.loc.emptyExpensesDescription,
      );
    } else {
      return ValueListenableBuilder<FilterExpense>(
        valueListenable: summaryController.filterHomeExpenseNotifier,
        builder: (_, value, __) {
          final maps = groupBy(
              expenses, (Expense element) => element.time.formatted(value));
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
        },
      );
    }
  }
}
