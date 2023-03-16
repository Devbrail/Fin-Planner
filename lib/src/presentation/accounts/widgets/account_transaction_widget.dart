import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/common.dart';
import '../../../core/extensions/account_extension.dart';
import '../../../data/accounts/data_sources/local_account_data_manager.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/widgets/expense_item_widget.dart';

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
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.money_off_rounded, size: 72),
              Text(context.loc.emptyExpensesMessage),
            ],
          ),
        ),
      );
    }
    return ScreenTypeLayout.builder(
      mobile: (_) => ListView(
        physics: isScroll ? null : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            title: Text(
              context.loc.transactionHistoryLabel,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(indent: 52, height: 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: expenses.length,
            itemBuilder: (_, index) {
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
        ],
      ),
      tablet: (_) => ListView(
        padding: const EdgeInsets.only(bottom: 128),
        shrinkWrap: true,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            title: Text(
              context.loc.transactionHistoryLabel,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: expenses.length,
            itemBuilder: (_, index) {
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
        ],
      ),
    );
  }
}
