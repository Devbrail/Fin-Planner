import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/accounts/data_sources/local_account_data_manager.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/widgets/expense_history_widget.dart';
import '../../summary/widgets/transactions_header_widget.dart';
import '../../widgets/paisa_empty_widget.dart';

class AccountTransactionWidget extends StatelessWidget {
  const AccountTransactionWidget({
    Key? key,
    required this.accountLocalDataSource,
    required this.categoryLocalDataSource,
    required this.expenses,
    this.isScroll = false,
  }) : super(key: key);

  final LocalAccountDataManager accountLocalDataSource;
  final LocalCategoryManagerDataSource categoryLocalDataSource;
  final List<Expense> expenses;
  final bool isScroll;
  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return EmptyWidget(
        title: context.loc.emptyExpensesMessageTitle,
        icon: Icons.money_off_rounded,
        description: context.loc.emptyExpensesMessageSubTitle,
      );
    }
    return ListView(
      physics: isScroll ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        TransactionsHeaderWidget(summaryController: getIt.get()),
        ExpenseHistory(expenses: expenses)
      ],
    );
  }
}
