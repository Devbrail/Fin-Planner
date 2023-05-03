import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../domain/expense/entities/expense.dart';
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
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.money_off_rounded,
                size: 72,
              ),
              Text(
                context.loc.emptyExpensesMessage,
              ),
            ],
          ),
        ),
      );
    } else {
      return ValueListenableBuilder<FilterThisExpense>(
        valueListenable: summaryController.filterThisExpenseNotifier,
        builder: (_, value, __) {
          final filteredExpenses = expenses.filterByThis(value);
          final maps = groupBy(
            filteredExpenses,
            (Expense element) => element.time.formatThis(value),
          );
          return ListView.builder(
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
