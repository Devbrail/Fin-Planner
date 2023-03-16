import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/extensions/account_extension.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../accounts/widgets/account_summary_widget.dart';
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
    final totalExpenseBalance = expenses.fullTotal;
    final totalAccountBalance =
        getIt.get<Box<AccountModel>>().totalAccountInitialAmount;
    final thisMonthExpenses = expenses.thisMonthExpense;
    final thisMonthIncome = expenses.thisMonthIncome;
    return Column(
      children: [
        LavaAnimation(
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
                  Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .color!
                      .withOpacity(0.1),
                  Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .color!
                      .withOpacity(0.05),
                ],
                stops: const [0.1, 1],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .color!
                      .withOpacity(0.5),
                  Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .color!
                      .withOpacity(0.5),
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
                      amount: totalExpenseBalance + totalAccountBalance,
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
        ),
        AccountSummaryWidget(expenses: expenses),
      ],
    );
  }
}
