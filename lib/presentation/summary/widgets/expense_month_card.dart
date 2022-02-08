import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constants/currency.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/expense/model/expense.dart';
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            getTwoDigitCurrency(total),
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: total.isNegative ? Colors.red : Colors.green,
                  ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: MaterialYouCard(
            child: ExpenseListWidget(expenses: expenses),
          ),
        ),
      ],
    );
  }
}
