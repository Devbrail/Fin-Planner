import 'package:flutter/widgets.dart';

import '../../../data/expense/model/expense.dart';
import 'expense_item_widget.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      itemBuilder: (_, index) {
        final Expense expense = expenses[index];
        return ExpensItemWidget(expense: expense);
      },
    );
  }
}
