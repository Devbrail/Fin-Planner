import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common.dart';
import '../../../core/theme/custom_color.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/paisa_expense_stats_widget.dart';

class AccountSummaryWidget extends StatelessWidget {
  const AccountSummaryWidget({
    super.key,
    required this.expenses,
    this.useAccountsList = false,
  });

  final List<Expense> expenses;
  final bool useAccountsList;

  @override
  Widget build(BuildContext context) {
    if (useAccountsList) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.loc.incomeLabel,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.75),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    expenses.thisMonthIncome.toCurrency(decimalDigits: 0),
                    style: GoogleFonts.manrope(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.loc.expenseLabel,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondaryContainer
                          .withOpacity(0.75),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    expenses.thisMonthExpense.toCurrency(decimalDigits: 0),
                    style: GoogleFonts.manrope(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: PaisaExpenseStatsWidget(
                total: expenses.totalIncome.toCurrency(decimalDigits: 0),
                title: context.loc.incomeLabel,
                graphData: expenses.incomeList.map((e) => e.currency).toList(),
                graphLineColor:
                    Theme.of(context).extension<CustomColors>()!.green ??
                        Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: PaisaExpenseStatsWidget(
                total: expenses.totalExpense.toCurrency(decimalDigits: 0),
                title: context.loc.expenseLabel,
                graphData: expenses.expenseList.map((e) => e.currency).toList(),
                graphLineColor:
                    Theme.of(context).extension<CustomColors>()!.red ??
                        Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      );
    }
  }
}
