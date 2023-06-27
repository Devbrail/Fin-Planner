import 'package:flutter/material.dart';

import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../controller/summary_controller.dart';
import 'expense_item_widget.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({
    Key? key,
    required this.expenses,
    required this.summaryController,
  }) : super(key: key);

  final List<Expense> expenses;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        indent: 72,
        height: 0,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      itemBuilder: (_, index) {
        final Expense expense = expenses[index];
        final Account? account =
            summaryController.fetchAccountFromId(expense.accountId);
        final Category? category =
            summaryController.fetchCategoryFromId(expense.categoryId);
        if (account == null || category == null) {
          return const SizedBox.shrink();
        } else {
          return ExpenseItemWidget(
            expense: expense,
            account: account,
            category: category,
          );
        }
      },
    );
  }
}
