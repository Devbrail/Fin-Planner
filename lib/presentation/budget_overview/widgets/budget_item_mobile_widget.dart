import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/routes.dart';
import '../../../common/constants/currency.dart';

import '../../../common/constants/extensions.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';

class BudgetItemMobileWidget extends StatelessWidget {
  const BudgetItemMobileWidget({
    Key? key,
    required this.category,
    required this.expenses,
  }) : super(key: key);
  final Category category;
  final List<Expense> expenses;

  get isBudgetActive {
    final double budget = category.budget ?? 0.0;
    if (budget > 0.0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final double totalExpenses = expenses.total;
    final double totalBudget = category.budget ?? -1;
    double difference;
    if (isBudgetActive) {
      difference = totalBudget - totalExpenses;
    } else {
      difference = totalExpenses;
    }

    return MaterialYouCard(
      child: InkWell(
        onTap: () => context.goNamed(addCategoryPath, extra: category),
        child: Stack(
          children: [
            isBudgetActive
                ? SizedBox(
                    height: double.infinity,
                    child: LinearProgressIndicator(
                      value: totalExpenses / totalBudget,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                  )
                : const SizedBox.shrink(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14.0,
                              bottom: 8,
                              left: 14.0,
                              right: 8,
                            ),
                            child: Icon(
                              IconData(category.icon,
                                  fontFamily: 'MaterialIcons'),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              left: 14.0,
                              right: 8,
                            ),
                            child: Text(category.name),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Sparkline(
                      data: expenses.map((e) => e.currency).toList(),
                      useCubicSmoothing: true,
                      cubicSmoothingFactor: 0.2,
                      lineWidth: 3,
                      lineColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    '${isBudgetActive ? 'Balance:' : ''} ${formattedCurrency(difference)}',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
