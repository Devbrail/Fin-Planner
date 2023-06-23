import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common.dart';
import '../../../domain/expense/entities/expense.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryMobilePage extends StatelessWidget {
  const SummaryMobilePage({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.surface,
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        padding: const EdgeInsets.only(bottom: 124),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const WelcomeNameWidget();
          } else if (index == 1) {
            return ExpenseTotalWidget(expenses: expenses);
          } else if (index == 2) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              title: Text(
                context.loc.transactions,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  textStyle: context.titleMedium,
                  color: context.onBackground,
                ),
              ),
            );
          } else if (index == 3) {
            return ExpenseHistoryWidget(expenses: expenses);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
