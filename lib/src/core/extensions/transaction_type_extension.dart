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
        return context.loc.incomeLabel;
      case TransactionType.expense:
        return context.loc.expenseLabel;
      case TransactionType.transfer:
        return context.loc.transferLabel;
      case TransactionType.recurring:
        return 'Recurring';
    }
  }

  String hintName(BuildContext context) {
    switch (this) {
      case TransactionType.income:
        return context.loc.incomeNameLabel;
      case TransactionType.expense:
        return context.loc.expenseNameLabel;
      case TransactionType.transfer:
        return context.loc.transferNameLabel;
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
