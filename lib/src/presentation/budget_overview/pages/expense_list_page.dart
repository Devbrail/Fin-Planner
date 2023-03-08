import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../summary/widgets/expense_item_widget.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({
    super.key,
    required this.categoryId,
    required this.accountLocalDataSource,
    required this.categoryLocalDataSource,
  });

  final String? categoryId;

  final LocalAccountManagerDataSource accountLocalDataSource;
  final LocalCategoryManagerDataSource categoryLocalDataSource;
  @override
  Widget build(BuildContext context) {
    final int? cid = int.tryParse(categoryId ?? '');
    return Scaffold(
      appBar: context.materialYouAppBar(
        context.loc.expenseByCategoryLabel,
      ),
      body: ValueListenableBuilder<Box<Expense>>(
        valueListenable: getIt.get<Box<Expense>>().listenable(),
        builder: (context, value, _) {
          final expenses = value.values
              .where((element) => element.categoryId == cid)
              .toList();
          if (expenses.isEmpty) {
            return const Text('No data');
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: expenses.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpenseItemWidget(
                expense: expenses[index],
                account: accountLocalDataSource
                    .fetchAccount(expenses[index].accountId),
                category: categoryLocalDataSource
                    .fetchCategory(expenses[index].categoryId),
              );
            },
          );
        },
      ),
    );
  }
}
