import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:paisa/src/domain/expense/entities/expense.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/expense/model/expense_model.dart';
import 'expense_month_card.dart';

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({
    super.key,
    required this.valueNotifier,
    required this.expenses,
  });

  final ValueNotifier<FilterBudget> valueNotifier;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
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
      return ValueListenableBuilder<FilterBudget>(
        valueListenable: valueNotifier,
        builder: (_, value, __) {
          final maps = groupBy(
              expenses, (Expense element) => element.time.formatted(value));
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
