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
        onTap: () => context.goNamed(
          expensesByCategory,
          params: <String, String>{'cid': category.superId.toString()},
        ),
        child: Stack(
          children: [
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
                              IconData(
                                category.icon,
                                fontFamily: 'Material Design Icons',
                                fontPackage: 'material_design_icons_flutter',
                              ),
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
                    isBudgetActive
                        ? Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                value: totalExpenses / totalBudget,
                                color: Theme.of(context).colorScheme.primary,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
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
                    style: GoogleFonts.manrope(
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

class ProgressBar extends StatelessWidget {
  final double max;
  final double current;
  final Color? color;

  const ProgressBar({
    Key? key,
    required this.max,
    required this.current,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / max) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: 7,
              decoration: BoxDecoration(
                color: Color(0xffd3d3d3),
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: percent,
              height: 7,
              decoration: BoxDecoration(
                color: color ?? Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
