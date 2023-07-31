import 'package:flutter/material.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/transactions_history_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/expense_total_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/welcome_name_widget.dart';

class SummaryDesktopWidget extends StatelessWidget {
  const SummaryDesktopWidget({
    super.key,
    required this.transactions,
  });

  final List<CombinedTransactionEntity> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const WelcomeNameWidget(),
                    ExpenseTotalWidget(transactions: transactions),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 124),
                  children: [
                    TransactionsHistoryWidget(transactions: transactions),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
