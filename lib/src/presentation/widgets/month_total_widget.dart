import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/core/enum/transaction_type.dart';

import '../../core/theme/custom_color.dart';

class PaisaTransactionTailWidget extends StatelessWidget {
  const PaisaTransactionTailWidget({
    super.key,
    required this.content,
    required this.color,
    this.transactionType = TransactionType.expense,
  });
  final String content;
  final Color color;
  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: transactionType == TransactionType.income ? '▼' : '▲',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: transactionType == TransactionType.income
                      ? Theme.of(context).extension<CustomColors>()!.green
                      : Theme.of(context).extension<CustomColors>()!.red,
                ),
            children: [
              TextSpan(
                text: transactionType == TransactionType.income
                    ? context.loc.income
                    : context.loc.expense,
                style: TextStyle(
                  color: color.withOpacity(0.75),
                ),
              )
            ],
          ),
        ),
        Text(
          content,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
              ),
        ),
      ],
    );
  }
}
