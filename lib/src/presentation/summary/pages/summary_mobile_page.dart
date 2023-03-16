import 'package:flutter/material.dart';

import '../../../core/enum/filter_budget.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/filter_widget/filter_budget_widget.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryMobilePage extends StatelessWidget {
  const SummaryMobilePage({
    super.key,
    required this.valueNotifier,
    required this.expenses,
  });

  final ValueNotifier<FilterBudget> valueNotifier;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          padding: const EdgeInsets.only(bottom: 124),
          itemBuilder: (context, index) {
            if (index == 0) {
              return const WelcomeNameWidget();
            } else if (index == 1) {
              return ExpenseTotalWidget(expenses: expenses);
            } else if (index == 2) {
              return const SizedBox(height: 16);
            } else if (index == 3) {
              return FilterBudgetToggleWidget(valueNotifier: valueNotifier);
            } else if (index == 4) {
              return ExpenseHistory(
                valueNotifier: valueNotifier,
                expenses: expenses,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
}
