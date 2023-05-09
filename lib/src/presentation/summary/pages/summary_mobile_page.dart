import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/common.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/filter_widget/filter_budget_widget.dart';
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
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        padding: const EdgeInsets.only(bottom: 124),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const WelcomeNameWidget();
          } else if (index == 1) {
            return ExpenseTotalWidget(expenses: expenses);
          } else if (index == 2) {
            return const TransactionsHeaderWidget();
          } else if (index == 3) {
            return ExpenseHistory(expenses: expenses);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class TransactionsHeaderWidget extends StatelessWidget {
  const TransactionsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      title: Text(
        context.loc.transactionsLabel,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          textStyle: Theme.of(context).textTheme.titleLarge,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width >= 700
                  ? 700
                  : double.infinity,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            builder: (context) {
              return FilterHomeWidget();
            },
          );
        },
        icon: Icon(
          MdiIcons.filter,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
