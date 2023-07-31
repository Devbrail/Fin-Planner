import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/transacitons_by_month_card_widget.dart';
import 'package:paisa/features/home/presentation/controller/summary_controller.dart';

class AccountHistoryWidget extends StatelessWidget {
  const AccountHistoryWidget({
    super.key,
    required this.expenses,
    required this.summaryController,
  });

  final List<CombinedTransactionEntity> expenses;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return EmptyWidget(
        title: context.loc.emptyExpensesMessageTitle,
        icon: Icons.money_off_rounded,
        description: context.loc.emptyExpensesMessageSubTitle,
      );
    } else {
      return ValueListenableBuilder<FilterExpense>(
        valueListenable: summaryController.sortHomeExpenseNotifier,
        builder: (_, FilterExpense value, __) {
          final Map<String, List<CombinedTransactionEntity>> maps = groupBy(
              expenses,
              (CombinedTransactionEntity element) =>
                  element.time!.formatted(value));
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
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
        },
      );
    }
  }
}
