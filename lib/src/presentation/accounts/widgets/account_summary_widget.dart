import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    return ScreenTypeLayout(
      breakpoints: const ScreenBreakpoints(
        tablet: 600,
        desktop: 700,
        watch: 300,
      ),
      mobile: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: PaisaExpenseStatsWidget(
                total: expenses.totalIncome.toCurrency(decimalDigits: 0),
                title: context.loc.income,
                graphData: expenses.incomeList.map((e) => e.currency).toList(),
                graphLineColor:
                    Theme.of(context).extension<CustomColors>()!.green ??
                        Theme.of(context).colorScheme.secondary,
                iconData: MdiIcons.arrowBottomLeft,
              ),
            ),
            Expanded(
              child: PaisaExpenseStatsWidget(
                total: expenses.totalExpense.toCurrency(decimalDigits: 0),
                title: context.loc.expense,
                graphData: expenses.expenseList.map((e) => e.currency).toList(),
                graphLineColor:
                    Theme.of(context).extension<CustomColors>()!.red ??
                        Theme.of(context).colorScheme.secondary,
                iconData: MdiIcons.arrowTopRight,
              ),
            ),
          ],
        ),
      ),
      tablet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            PaisaExpenseStatsWidget(
              total: expenses.totalIncome.toCurrency(decimalDigits: 0),
              title: context.loc.income,
              graphData: expenses.incomeList.map((e) => e.currency).toList(),
              graphLineColor:
                  Theme.of(context).extension<CustomColors>()!.green ??
                      Theme.of(context).colorScheme.secondary,
              iconData: MdiIcons.arrowBottomLeft,
            ),
            PaisaExpenseStatsWidget(
              total: expenses.totalExpense.toCurrency(decimalDigits: 0),
              title: context.loc.expense,
              graphData: expenses.expenseList.map((e) => e.currency).toList(),
              graphLineColor:
                  Theme.of(context).extension<CustomColors>()!.red ??
                      Theme.of(context).colorScheme.secondary,
              iconData: MdiIcons.arrowTopRight,
            ),
          ],
        ),
      ),
      desktop: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: PaisaExpenseStatsWidget(
                total: expenses.totalIncome.toCurrency(decimalDigits: 0),
                title: context.loc.income,
                graphData: expenses.incomeList.map((e) => e.currency).toList(),
                graphLineColor:
                    Theme.of(context).extension<CustomColors>()!.green ??
                        Theme.of(context).colorScheme.secondary,
                iconData: MdiIcons.arrowBottomLeft,
              ),
            ),
            Expanded(
              child: PaisaExpenseStatsWidget(
                total: expenses.totalExpense.toCurrency(decimalDigits: 0),
                title: context.loc.expense,
                graphData: expenses.expenseList.map((e) => e.currency).toList(),
                graphLineColor:
                    Theme.of(context).extension<CustomColors>()!.red ??
                        Theme.of(context).colorScheme.secondary,
                iconData: MdiIcons.arrowTopRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
