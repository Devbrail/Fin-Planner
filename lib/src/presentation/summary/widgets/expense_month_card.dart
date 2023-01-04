import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/currency_util.dart';
import '../../../core/theme/custom_color.dart';
import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import 'expense_list_widget.dart';

class ExpenseMonthCardWidget extends StatelessWidget {
  const ExpenseMonthCardWidget({
    Key? key,
    required this.title,
    required this.total,
    required this.expenses,
    required this.accountSource,
    required this.categorySource,
  }) : super(key: key);

  final String title;
  final double total;
  final List<Expense> expenses;
  final LocalAccountManagerDataSource accountSource;
  final LocalCategoryManagerDataSource categorySource;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Text(
                total.toCurrency(),
                style: GoogleFonts.manrope(
                  textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: total.isNegative
                            ? Theme.of(context).extension<CustomColors>()!.red
                            : Theme.of(context)
                                .extension<CustomColors>()!
                                .green,
                      ),
                ),
              )
            ],
          ),
        ),
        ExpenseListWidget(
          expenses: expenses,
          accountLocalDataSource: accountSource,
          categoryLocalDataSource: categorySource,
        ),
      ],
    );
  }
}
