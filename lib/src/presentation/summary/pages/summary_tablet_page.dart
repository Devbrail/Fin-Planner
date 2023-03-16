import 'package:flutter/material.dart';

import '../../../core/enum/filter_budget.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/filter_widget/filter_budget_widget.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryTabletPage extends StatelessWidget {
  const SummaryTabletPage({
    super.key,
    required this.valueNotifier,
    required this.expenses,
  });

  final ValueNotifier<FilterBudget> valueNotifier;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const WelcomeNameWidget(),
                  ExpenseTotalWidget(expenses: expenses),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 124),
                children: [
                  FilterBudgetToggleWidget(valueNotifier: valueNotifier),
                  ExpenseHistory(
                    valueNotifier: valueNotifier,
                    expenses: expenses,
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
