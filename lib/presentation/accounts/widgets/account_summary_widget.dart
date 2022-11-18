import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common.dart';
import '../../../common/theme/custom_color.dart';
import '../../../data/expense/model/expense.dart';
import '../../widgets/paisa_card.dart';

class AccountSummaryWidget extends StatelessWidget {
  const AccountSummaryWidget({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: PaisaCard(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.incomeLabel,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer
                            .withOpacity(0.75),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formattedCurrency(expenses.totalIncome, decimalDigits: 0),
                      style: GoogleFonts.manrope(
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Sparkline(
                          data: expenses.incomeList
                              .map((e) => e.currency)
                              .toList(),
                          useCubicSmoothing: true,
                          cubicSmoothingFactor: 0.2,
                          lineWidth: 3,
                          lineColor: Theme.of(context)
                                  .extension<CustomColors>()!
                                  .green ??
                              Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: PaisaCard(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.expenseLabel,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer
                            .withOpacity(0.75),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formattedCurrency(expenses.totalExpense,
                          decimalDigits: 0),
                      style: GoogleFonts.manrope(
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Sparkline(
                          data: expenses.expenseList
                              .map((e) => e.currency)
                              .toList(),
                          useCubicSmoothing: true,
                          cubicSmoothingFactor: 0.2,
                          lineWidth: 3,
                          lineColor: Theme.of(context)
                                  .extension<CustomColors>()!
                                  .red ??
                              Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
