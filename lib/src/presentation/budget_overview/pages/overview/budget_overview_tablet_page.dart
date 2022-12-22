import 'package:flutter/material.dart';

import '../../../../core/enum/filter_budget.dart';
import '../../../filter_widget/filter_budget_widget.dart';

class BudgetOverviewTabletPage extends StatelessWidget {
  const BudgetOverviewTabletPage(
      {super.key, required this.valueNotifier, required this.child});

  final ValueNotifier<FilterBudget> valueNotifier;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 24),
          FilterBudgetToggleWidget(
            valueNotifier: valueNotifier,
          ),
          child
        ],
      ),
    );
  }
}
