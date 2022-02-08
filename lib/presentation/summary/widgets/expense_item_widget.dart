import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../app/routes.dart';
import '../../../common/constants/currency.dart';
import '../../../common/constants/theme.dart';
import '../../../common/enum/transaction.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/expense/model/expense.dart';

class ExpensItemWidget extends StatelessWidget {
  const ExpensItemWidget({
    Key? key,
    required this.expense,
    required this.account,
  }) : super(key: key);
  final Account account;
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    final date = _readableDateWeekTime(expense.time);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        addExpenseScreen,
        arguments: expense,
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
              style: GoogleFonts.outfit(
                  textStyle: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.onSurface(context)),
            ),
            Text(
              date.substring(2, date.length),
              style: Theme.of(context).textTheme.bodyText1?.onSurface(context),
            ),
          ],
        ),
        title: Text(expense.name),
        subtitle: Text('${account.name} • ${account.bankName}'),
        trailing: _type(),
      ),
    );
  }

  Color get _typeColor {
    if (expense.type == TransactonType.deposit) {
      return Colors.blue;
    } else if (expense.type == TransactonType.expense) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  String get _typeSign {
    if (expense.type == TransactonType.deposit) {
      return '';
    } else if (expense.type == TransactonType.expense) {
      return '-';
    } else {
      return '+';
    }
  }

  Widget _type() {
    return RichText(
      text: TextSpan(
        text: _typeSign,
        style: GoogleFonts.manrope(
          textStyle: TextStyle(color: _typeColor),
        ),
        children: [
          TextSpan(text: getTwoDigitCurrency(expense.currency)),
        ],
      ),
    );
  }

  String _readableDateWeekTime(DateTime time) {
    return DateFormat('dd EEE').format(time);
  }
}
