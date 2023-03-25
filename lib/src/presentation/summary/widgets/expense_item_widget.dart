import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';

class ExpenseItemWidget extends StatelessWidget {
  const ExpenseItemWidget({
    Key? key,
    required this.expense,
    required this.account,
    required this.category,
  }) : super(key: key);

  final Account account;
  final Expense expense;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.goNamed(
          editExpensePath,
          params: <String, String>{'eid': expense.superId.toString()},
        ),
        child: ListTile(
          horizontalTitleGap: 4,
          title: Text(expense.name),
          subtitle: Text(
            '${account.bankName} • ${expense.time.shortDayString}',
          ),
          leading: Icon(
            IconData(
              category.icon,
              fontFamily: 'Material Design Icons',
              fontPackage: 'material_design_icons_flutter',
            ),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          trailing: Text(
            '${expense.type?.sign}${expense.currency.toCurrency()}',
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: expense.type?.color(context),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
