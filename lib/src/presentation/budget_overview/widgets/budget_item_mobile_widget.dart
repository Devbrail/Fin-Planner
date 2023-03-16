import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../data/category/model/category_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/paisa_card.dart';

class BudgetItemMobileWidget extends StatelessWidget {
  const BudgetItemMobileWidget({
    Key? key,
    required this.category,
    required this.expenses,
  }) : super(key: key);
  final CategoryModel category;
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

    return PaisaFilledCard(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              bottom: 8,
                              left: 16.0,
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
                              left: 16.0,
                              right: 8,
                            ),
                            child: Text(
                              category.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isBudgetActive
                        ? Padding(
                            padding: const EdgeInsets.only(
                              right: 16,
                              top: 16,
                            ),
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Sparkline(
                        data: expenses.map((e) => e.currency).toList(),
                        useCubicSmoothing: true,
                        cubicSmoothingFactor: 0.2,
                        lineWidth: 3,
                        lineColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    ' ${difference.toCurrency()}',
                    style: GoogleFonts.manrope(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
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
