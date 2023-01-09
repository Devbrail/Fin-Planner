import 'package:flutter/material.dart';

import '../../../core/enum/filter_budget.dart';
import '../../home/widgets/welcome_widget.dart';
import '../../settings/widgets/user_profile_widget.dart';
import '../../widgets/color_palette.dart';
import '../../widgets/filter_widget/filter_budget_widget.dart';
import '../../widgets/paisa_search_bar.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryDesktopPage extends StatelessWidget {
  const SummaryDesktopPage({
    super.key,
    required this.valueNotifier,
  });
  final ValueNotifier<FilterBudget> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: ExpenseTotalWidget(),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 124),
                      children: [
                        FilterBudgetToggleWidget(valueNotifier: valueNotifier),
                        ExpenseHistory(valueNotifier: valueNotifier),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
