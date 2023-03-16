import 'package:flutter/material.dart';

import '../../../../core/enum/filter_budget.dart';

class BudgetOverviewMobilePage extends StatelessWidget {
  const BudgetOverviewMobilePage({
    super.key,
    required this.valueNotifier,
    required this.child,
  });

  final ValueNotifier<FilterBudget> valueNotifier;
  final Widget child;
  @override
  Widget build(BuildContext context) => Scaffold(body: child);
}
