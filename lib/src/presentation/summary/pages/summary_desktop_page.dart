import 'package:flutter/material.dart';

import '../../../domain/expense/entities/expense.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryDesktopPage extends StatelessWidget {
  const SummaryDesktopPage({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
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
                    ExpenseHistoryWidget(expenses: expenses),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
