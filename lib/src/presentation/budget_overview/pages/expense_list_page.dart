import 'package:flutter/material.dart';
import 'package:paisa/src/domain/expense/entities/expense.dart';

import '../../../core/common.dart';
import '../../../core/extensions/account_extension.dart';
import '../../../data/accounts/data_sources/local_account_data_manager.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/data_sources/local_expense_data_manager.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../summary/widgets/expense_item_widget.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({
    super.key,
    required this.categoryId,
    required this.accountLocalDataSource,
    required this.categoryLocalDataSource,
    required this.expenseDataManager,
  });

  final String categoryId;
  final LocalAccountDataManager accountLocalDataSource;
  final LocalCategoryManagerDataSource categoryLocalDataSource;
  final LocalExpenseDataManager expenseDataManager;

  @override
  Widget build(BuildContext context) {
    final int cid = int.parse(categoryId);
    final List<Expense> expenses =
        expenseDataManager.fetchExpensesFromCategoryId(cid).toEntities();
    if (expenses.isEmpty) {
      return const Text('No data');
    }
    return Scaffold(
      appBar: context.materialYouAppBar(
        context.loc.expenseByCategoryLabel,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          final Account account = accountLocalDataSource
              .fetchAccountFromId(expenses[index].accountId)!
              .toEntity();
          final Category category = categoryLocalDataSource
              .fetchCategoryFromId(expenses[index].categoryId)!
              .toEntity();
          return ExpenseItemWidget(
            expense: expenses[index],
            account: account,
            category: category,
          );
        },
      ),
    );
  }
}
