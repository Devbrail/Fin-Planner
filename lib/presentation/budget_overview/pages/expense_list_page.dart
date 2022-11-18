import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../common/constants/context_extensions.dart';
import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import '../../summary/widgets/expense_item_widget.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({
    super.key,
    required this.categoryId,
    required this.accountLocalDataSource,
    required this.categoryLocalDataSource,
  });

  final String? categoryId;

  final AccountLocalDataSource accountLocalDataSource;
  final CategoryLocalDataSource categoryLocalDataSource;
  @override
  Widget build(BuildContext context) {
    final int? cid = int.tryParse(categoryId ?? '');
    return Scaffold(
      appBar: context.materialYouAppBar(
        AppLocalizations.of(context)!.expenseByCategoryLabel,
      ),
      body: ValueListenableBuilder<Box<Expense>>(
        valueListenable: locator.get<Box<Expense>>().listenable(),
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
