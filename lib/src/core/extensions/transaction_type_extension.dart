import 'package:flutter/material.dart';

import '../common.dart';
import '../enum/transaction.dart';
import '../theme/custom_color.dart';

extension TransactionTypeHelper on TransactionType {
  String get sign => this == TransactionType.transfer
      ? ''
      : this == TransactionType.expense
          ? '-'
          : '+';

  Color? color(BuildContext context) => this == TransactionType.transfer
      ? Theme.of(context).extension<CustomColors>()!.blue
      : this == TransactionType.expense
          ? Theme.of(context).extension<CustomColors>()!.red
          : Theme.of(context).extension<CustomColors>()!.green;

  String stringName(BuildContext context) {
    switch (this) {
      case TransactionType.income:
        return context.loc.income;
      case TransactionType.expense:
        return context.loc.expense;
      case TransactionType.transfer:
        return context.loc.transfer;
      case TransactionType.recurring:
        return 'Recurring';
    }
  }

  String hintName(BuildContext context) {
    switch (this) {
      case TransactionType.income:
        return context.loc.incomeName;
      case TransactionType.expense:
        return context.loc.expenseName;
      case TransactionType.transfer:
        return context.loc.transferName;
      case TransactionType.recurring:
        return 'Recurring';
    }
  }
}

extension TransactionMap on String {
  TransactionType get transactionType {
    switch (this) {
      case 'expense':
        return TransactionType.expense;
      case 'income':
        return TransactionType.income;
      case 'transfer':
        return TransactionType.transfer;
      case 'recurring':
        return TransactionType.recurring;
    }
    return TransactionType.expense;
  }
}
