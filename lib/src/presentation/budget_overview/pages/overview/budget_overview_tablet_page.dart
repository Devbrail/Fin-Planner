import 'package:flutter/material.dart';
import '../../../widgets/filter_widget/paisa_filter_transaction_widget.dart';

import '../../../../core/enum/filter_budget.dart';

class BudgetOverviewTabletPage extends StatelessWidget {
  const BudgetOverviewTabletPage({
    super.key,
    required this.valueNotifier,
    required this.child,
  });

  final ValueNotifier<FilterBudget> valueNotifier;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          PaisaFilterTransactionWidget(),
        ],
      ),
      body: child,
    );
  }
}
