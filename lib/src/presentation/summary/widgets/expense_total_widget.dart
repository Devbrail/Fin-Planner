import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import '../../../core/common.dart';
import '../../../data/expense/model/expense.dart';
import '../../../service_locator.dart';
import '../../accounts/widgets/account_summary_widget.dart';
import '../../widgets/paisa_card.dart';
import 'expense_total_for_month_widget.dart';
import 'total_balance_widget.dart';

class ExpenseTotalWidget extends StatelessWidget {
  const ExpenseTotalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: locator.get<Box<Expense>>().listenable(),
      builder: (_, value, child) {
        final expenses = value.values.toList();
        final currentTotal = expenses.fullTotal;
        final thisMonthExpenses = expenses.thisMonthExpense;
        final thisMonthIncome = expenses.thisMonthIncome;
        return Column(
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
            const SizedBox(height: 8),
            AccountSummaryWidget(expenses: expenses),
          ],
        );
      },
    );
  }
}
