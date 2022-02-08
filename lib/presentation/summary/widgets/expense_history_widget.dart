import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../common/constants/time.dart';
import '../../../common/constants/util.dart';
import '../../../common/enum/filter_budget.dart';
import '../../../common/enum/transaction.dart';
import '../../../data/expense/model/expense.dart';
import '../../budget_overview/widgets/filter_budget_widget.dart';
import 'expense_month_card.dart';

class ExpenseHistory extends StatefulWidget {
  const ExpenseHistory({Key? key}) : super(key: key);

  @override
  State<ExpenseHistory> createState() => _ExpenseHistoryState();
}

class _ExpenseHistoryState extends State<ExpenseHistory> {
  FilterBudget selectedType = FilterBudget.daily;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: Hive.box<Expense>('expense').listenable(),
      builder: (BuildContext context, value, Widget? child) {
        final expenses = value.values.toList();
        if (expenses.isEmpty) return const SizedBox.shrink();
        expenses.sort(((a, b) => b.time.compareTo(a.time)));
        final maps = groupBy(
            expenses, (Expense element) => element.time.formated(selectedType));
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            FilterBudgetWidget(
              onSelected: (budget) {
                selectedType = budget;
                setState(() {});
              },
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: maps.entries.length,
              itemBuilder: (_, mapIndex) {
                final expenses = maps.values.toList()[mapIndex];
                expenses.sort((a, b) => b.time.compareTo(a.time));
                final double total = calcauleTotal(expenses);
                return ExpenseMonthCardWidget(
                  title: maps.keys.toList()[mapIndex],
                  total: total,
                  expenses: expenses,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

double calcauleTotal(List<Expense> expenses) {
  final total = expenses.fold<double>(0, (previousValue, element) {
    if (element.type == TransactonType.deposit) return previousValue + 0;
    if (element.type == TransactonType.expense) {
      return previousValue - element.currency;
    } else {
      return previousValue + element.currency;
    }
  });
  return total;
}
