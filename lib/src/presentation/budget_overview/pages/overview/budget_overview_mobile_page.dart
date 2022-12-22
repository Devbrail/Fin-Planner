import 'package:flutter/material.dart';

import '../../../../core/enum/filter_budget.dart';
import '../../../widgets/filter_widget/filter_budget_widget.dart';

class BudgetOverviewMobilePage extends StatelessWidget {
  const BudgetOverviewMobilePage({
    super.key,
    required this.valueNotifier,
    required this.child,
  });

  final ValueNotifier<FilterBudget> valueNotifier;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterBudgetToggleWidget(valueNotifier: valueNotifier),
          child,
        ],
      ),
    );
  }
}
