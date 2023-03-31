import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/currency_util.dart';
import '../../../core/theme/custom_color.dart';
import '../../../domain/expense/entities/expense.dart';
import 'expense_list_widget.dart';

class ExpenseMonthCardWidget extends StatelessWidget {
  const ExpenseMonthCardWidget({
    Key? key,
    required this.title,
    required this.total,
    required this.expenses,
  }) : super(key: key);

  final String title;
  final double total;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              textStyle: Theme.of(context).textTheme.titleMedium,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          trailing: Text(
            total.toCurrency(),
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: total.isNegative
                        ? Theme.of(context).extension<CustomColors>()!.red
                        : Theme.of(context).extension<CustomColors>()!.green,
                  ),
            ),
          ),
        ),
        ExpenseListWidget(
          expenses: expenses,
        ),
      ],
    );
  }
}
