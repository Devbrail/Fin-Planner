import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/src/core/enum/transaction_type.dart';
import 'package:paisa/src/presentation/widgets/month_total_widget.dart';

import '../../../core/common.dart';
import '../../../core/theme/custom_color.dart';

class ExpenseTotalForMonthWidget extends StatelessWidget {
  const ExpenseTotalForMonthWidget({
    Key? key,
    required this.income,
    required this.outcome,
  }) : super(key: key);

  final double income;
  final double outcome;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.total,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withOpacity(0.85),
              ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PaisaTransactionTailWidget(
                content: '+${income.toFormateCurrency()}',
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                transactionType: TransactionType.income,
              ),
            ),
            Expanded(
              child: PaisaTransactionTailWidget(
                content: '-${outcome.toFormateCurrency()}',
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
