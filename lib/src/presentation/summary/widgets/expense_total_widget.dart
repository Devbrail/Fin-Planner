import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/extensions/account_extension.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../accounts/widgets/account_summary_widget.dart';
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
    final totalExpenseBalance = expenses.fullTotal;
    final totalAccountBalance =
        getIt.get<Box<AccountModel>>().totalAccountInitialAmount;
    final thisMonthExpenses = expenses.thisMonthExpense;
    final thisMonthIncome = expenses.thisMonthIncome;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: PaisaCard(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TotalBalanceWidget(
                      title: context.loc.totalBalanceLabel,
                      amount: totalExpenseBalance + totalAccountBalance,
                    ),
                    const Spacer(),
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
