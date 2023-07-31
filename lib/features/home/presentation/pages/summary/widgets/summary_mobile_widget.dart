import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/transactions_history_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/expense_total_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/welcome_name_widget.dart';

class SummaryMobileWidget extends StatelessWidget {
  const SummaryMobileWidget({
    super.key,
    required this.transactions,
  });

  final List<CombinedTransactionEntity> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.surface,
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        padding: const EdgeInsets.only(bottom: 124),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const WelcomeNameWidget();
          } else if (index == 1) {
            return ExpenseTotalWidget(transactions: transactions);
          } else if (index == 2) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              title: Text(
                context.loc.transactions,
                style: context.titleMedium?.copyWith(
                  color: context.onBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else if (index == 3) {
            return TransactionsHistoryWidget(transactions: transactions);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
