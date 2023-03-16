import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../core/extensions/account_extension.dart';
import '../../../data/accounts/data_sources/local_account_data_manager.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import 'expense_item_widget.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({
    Key? key,
    required this.expenses,
    required this.categoryLocalDataSource,
    required this.accountLocalDataSource,
  }) : super(key: key);

  final List<Expense> expenses;
  final LocalAccountDataManager accountLocalDataSource;
  final LocalCategoryManagerDataSource categoryLocalDataSource;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      itemBuilder: (_, index) {
        final expense = expenses[index];
        final Account account = accountLocalDataSource
            .fetchAccountFromId(expenses[index].accountId)!
            .toEntity();
        final Category category = categoryLocalDataSource
            .fetchCategoryFromId(expenses[index].categoryId)!
            .toEntity();
        return ExpenseItemWidget(
          expense: expense,
          account: account,
          category: category,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(indent: 52, height: 0),
    );
  }
}
