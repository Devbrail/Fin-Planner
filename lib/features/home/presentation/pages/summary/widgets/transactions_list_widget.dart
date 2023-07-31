import 'package:flutter/material.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';

import 'transaction_widget.dart';

class TransactionsListWidget extends StatelessWidget {
  const TransactionsListWidget({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  final List<CombinedTransactionEntity> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(
        indent: 72,
        height: 0,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (_, int index) {
        final CombinedTransactionEntity transaction = transactions[index];
        return TransactionWidget(
          expense: transaction,
          account: transaction.account,
          category: transaction.category,
        );
      },
    );
  }
}
