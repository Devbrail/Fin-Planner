import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../core/enum/transaction_type.dart';
import '../../summary/controller/summary_controller.dart';

class CategoryTransactionFilterWidget extends StatelessWidget {
  const CategoryTransactionFilterWidget({
    super.key,
    required this.summaryController,
  });

  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ValueListenableBuilder<TransactionType>(
        valueListenable: summaryController.typeNotifier,
        builder: (context, type, child) {
          return SegmentedButton<TransactionType>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment<TransactionType>(
                value: TransactionType.income,
                label: Text(context.loc.income),
              ),
              ButtonSegment<TransactionType>(
                value: TransactionType.expense,
                label: Text(context.loc.expense),
              ),
            ],
            selected: <TransactionType>{type},
            onSelectionChanged: (newSelection) {
              summaryController.typeNotifier.value = newSelection.first;
            },
          );
        },
      ),
    );
  }
}
