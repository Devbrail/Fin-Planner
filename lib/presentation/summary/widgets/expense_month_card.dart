import 'package:flutter/material.dart';
import '../../../di/service_locator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constants/currency.dart';
import '../../../common/theme/custom_color.dart';
import '../../widgets/paisa_card.dart';
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
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            formattedCurrency(total),
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: total.isNegative
                        ? Theme.of(context).extension<CustomColors>()!.red
                        : Theme.of(context).extension<CustomColors>()!.green,
                  ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PaisaCard(
            child: ExpenseListWidget(
              expenses: expenses,
              accountLocalDataSource: locator.get(),
              categoryLocalDataSource: locator.get(),
            ),
          ),
        ),
      ],
    );
  }
}
