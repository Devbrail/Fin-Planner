import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/card_type.dart';
import '../../../core/enum/transaction.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';

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
    return InkWell(
      onTap: () => context.goNamed(
        editExpensePath,
        params: <String, String>{'eid': expense.superId.toString()},
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              expense.time.dayString,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                textStyle: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            Text(
              expense.time.weekString,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ],
        ),
        title: Text(expense.name),
        subtitle: Text(
          '${account.cardType?.name} • ${account.bankName}',
        ),
        trailing: Text(
          '${expense.type?.sign}${expense.currency.toCurrency()}',
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              color: expense.type?.color(context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
