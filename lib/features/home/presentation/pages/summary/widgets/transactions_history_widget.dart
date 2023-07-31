import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';

import 'package:paisa/core/widgets/paisa_widget.dart';
import 'transacitons_by_month_card_widget.dart';

class TransactionsHistoryWidget extends StatelessWidget {
  const TransactionsHistoryWidget({
    super.key,
    required this.transactions,
  });

  final List<CombinedTransactionEntity> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return EmptyWidget(
        title: context.loc.emptyExpensesMessageTitle,
        icon: Icons.money_off_rounded,
        description: context.loc.emptyExpensesMessageSubTitle,
      );
    } else {
      final Map<String, List<CombinedTransactionEntity>> maps = groupBy(
          transactions,
          (CombinedTransactionEntity element) =>
              element.time!.formatted(FilterExpense.monthly));
      return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: maps.entries.length,
        itemBuilder: (_, int mapIndex) => TransactionsByMonthCard(
          title: maps.keys.elementAt(mapIndex),
          total: 0.0, // maps.values.elementAt(mapIndex).filterTotal,
          transactions: maps.values.elementAt(mapIndex),
        ),
      );
    }
  }
}
