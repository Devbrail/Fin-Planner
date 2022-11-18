import 'package:flutter/material.dart';
import '../../../common/theme/custom_color.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../app/routes.dart';
import '../../../common/constants/currency.dart';
import '../../../common/enum/card_type.dart';
import '../../../common/enum/transaction.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';

class ExpenseItemWidget extends StatefulWidget {
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
  State<ExpenseItemWidget> createState() => _ExpenseItemWidgetState();
}

class _ExpenseItemWidgetState extends State<ExpenseItemWidget> {
  String get _typeSign =>
      widget.expense.type == TransactionType.expense ? '-' : '+';
  Color? get color => widget.expense.type == TransactionType.expense
      ? Theme.of(context).extension<CustomColors>()!.red
      : Theme.of(context).extension<CustomColors>()!.green;

  String get day => DateFormat('dd').format(widget.expense.time);
  String get week => DateFormat('EEE').format(widget.expense.time);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(
        editExpensePath,
        params: <String, String>{'eid': widget.expense.superId.toString()},
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        horizontalTitleGap: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              day,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                textStyle: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            Text(
              week,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ],
        ),
        title: Text(widget.expense.name),
        subtitle: Text(
            '${widget.account.cardType?.name} • ${widget.account.bankName}'),
        trailing: Text(
          '$_typeSign${formattedCurrency(widget.expense.currency)}',
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
