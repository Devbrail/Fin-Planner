import 'package:flutter/widgets.dart';

import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import 'expense_item_widget.dart';

class ExpenseListWidget extends StatelessWidget {
  ExpenseListWidget({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<Expense> expenses;

  final AccountLocalDataSource dataSource = locator.get();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      itemBuilder: (_, index) {
        final expense = expenses[index];
        final account = dataSource.fetchAccount(expense.accountId);
        return ExpenseItemWidget(
          expense: expense,
          account: account,
        );
      },
    );
  }
}
