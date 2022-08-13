import 'package:flutter/material.dart';
import '../../../common/theme/custom_color.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../app/routes.dart';
import '../../../common/constants/currency.dart';
import '../../../common/theme/paisa_theme.dart';
import '../../../common/enum/transaction.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/expense/model/expense.dart';
import '../../../common/enum/card_type.dart';

class ExpensItemWidget extends StatefulWidget {
  const ExpensItemWidget({
    Key? key,
    required this.expense,
    required this.account,
  }) : super(key: key);
  final Account account;
  final Expense expense;

  @override
  State<ExpensItemWidget> createState() => _ExpensItemWidgetState();
}

class _ExpensItemWidgetState extends State<ExpensItemWidget> {
  Color? get _typeColor {
    if (widget.expense.type == TransactonType.expense) {
      return Theme.of(context).extension<CustomColors>()!.red;
    } else {
      return Theme.of(context).extension<CustomColors>()!.green;
    }
  }

  String get _typeSign {
    if (widget.expense.type == TransactonType.expense) {
      return '-';
    } else {
      return '+';
    }
  }

  Widget _type() {
    return RichText(
      text: TextSpan(
        text: _typeSign,
        style: GoogleFonts.lato(
          textStyle: TextStyle(color: _typeColor),
        ),
        children: [
          TextSpan(text: formattedCurrency(widget.expense.currency)),
        ],
      ),
    );
  }

  String _readableDateWeekTime(DateTime time) {
    return DateFormat('dd EEE').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final date = _readableDateWeekTime(widget.expense.time);

    return InkWell(
      onTap: () => context.goNamed(
        addExpensePath,
        extra: widget.expense,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              date.substring(0, 2),
              style: GoogleFonts.lato(
                textStyle:
                    Theme.of(context).textTheme.headline6?.onSurface(context),
              ),
            ),
            Text(
              date.substring(2, date.length),
              style: Theme.of(context).textTheme.bodyText1?.onSurface(context),
            ),
          ],
        ),
        title: Text(widget.expense.name),
        subtitle: Text(
            '${widget.account.cardType?.name} • ${widget.account.bankName}'),
        trailing: _type(),
      ),
    );
  }
}
