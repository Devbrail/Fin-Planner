import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../core/common.dart';
import '../../../data/expense/model/expense.dart';
import '../../widgets/lava/lava_clock.dart';
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
    final currentTotal = expenses.accountTotal;
    final thisMonthExpenses = expenses.thisMonthExpense;
    final thisMonthIncome = expenses.thisMonthIncome;
    return LavaAnimation(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GlassmorphicContainer(
          height: 226,
          width: MediaQuery.of(context).size.width,
          borderRadius: 24,
          blur: 7,
          alignment: Alignment.center,
          border: 2,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.1),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.05),
            ],
            stops: const [0.1, 1],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
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
    );
  }
}
