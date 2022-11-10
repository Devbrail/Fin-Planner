import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
        leading: Icon(
          IconData(
            widget.category.icon,
            fontFamily: 'Material Design Icons',
            fontPackage: 'material_design_icons_flutter',
          ),
          size: 28,
        ),
        title: Text(widget.expense.name),
        subtitle: Text(
            '${widget.account.cardType?.name} • ${widget.account.bankName}'),
        trailing: Text(
          '$_typeSign${formattedCurrency(widget.expense.currency)}',
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
