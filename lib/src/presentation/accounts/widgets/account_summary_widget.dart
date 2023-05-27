import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              context.loc.thisMonth,
              style: GoogleFonts.outfit(
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.85),
                    ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: PaisaExpenseStatsWidget(
                  total: expenses.thisMonthIncome.toFormateCurrency(),
                  title: context.loc.income,
                  graphLineColor:
                      Theme.of(context).extension<CustomColors>()!.green ??
                          Theme.of(context).colorScheme.secondary,
                  iconData: MdiIcons.arrowBottomLeft,
                ),
              ),
              Expanded(
                child: PaisaExpenseStatsWidget(
                  total: expenses.thisMonthExpense.toFormateCurrency(),
                  title: context.loc.expense,
                  graphLineColor:
                      Theme.of(context).extension<CustomColors>()!.red ??
                          Theme.of(context).colorScheme.secondary,
                  iconData: MdiIcons.arrowTopRight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
