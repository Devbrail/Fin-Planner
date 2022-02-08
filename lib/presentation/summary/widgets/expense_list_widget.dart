import 'package:flutter/widgets.dart';

import '../../../data/accounts/datasources/account_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import 'expense_item_widget.dart';

class ExpenseListWidget extends StatelessWidget {
  ExpenseListWidget({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<Expense> expenses;

  final AccountDataSource dataSource = locator.get();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      itemBuilder: (_, index) {
        final expense = expenses[index];
        final account = dataSource.fetchAccount(expense.accountId);
        return ExpensItemWidget(
          expense: expense,
          account: account,
        );
      },
    );
  }
}
