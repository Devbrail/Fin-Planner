import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../data/expense/model/expense.dart';
import '../../widgets/paisa_card.dart';
import 'expense_total_for_month_widget.dart';
import 'total_balance_widget.dart';

class ExpenseTotalWidget extends StatelessWidget {
  const ExpenseTotalWidget({
    Key? key,
    required this.expenses,
  }) : super(key: key);
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final currentTotal = expenses.fullTotal;
    final thisMonthExpenses = expenses.thisMonthExpense;
    final thisMonthIncome = expenses.thisMonthIncome;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PaisaCard(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TotalBalanceWidget(
                    title: context.loc.totalBalanceLabel,
                    amount: currentTotal,
                  ),
                  const SizedBox(height: 24),
                  ExpenseTotalForMonthWidget(
                    outcome: thisMonthExpenses,
                    income: thisMonthIncome,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
