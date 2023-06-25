import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/controller/summary_controller.dart';
import '../../summary/widgets/expense_item_widget.dart';
import '../../widgets/paisa_annotate_region_widget.dart';

class TransactionByCategoryListPage extends StatelessWidget {
  const TransactionByCategoryListPage({
    super.key,
    required this.categoryId,
    required this.summaryController,
  });

  final String categoryId;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    final int cid = int.parse(categoryId);
    final List<Expense> expenses =
        summaryController.fetchExpensesFromCategoryId(cid);

    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        appBar: context.materialYouAppBar(context.loc.transactionsByCategory),
        bottomNavigationBar: SafeArea(
          child: ListTile(
            title: Text(
              expenses.total.toFormateCurrency(),
              style: context.titleMedium,
            ),
            subtitle: Text(
              context.loc.total,
              style: context.titleMedium,
            ),
          ),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: expenses.length,
          itemBuilder: (BuildContext context, int index) {
            final Account? account =
                summaryController.fetchAccountFromId(expenses[index].accountId);
            final Category? category = summaryController
                .fetchCategoryFromId(expenses[index].categoryId);
            if (account == null || category == null) {
              return const SizedBox.shrink();
            }
            return ExpenseItemWidget(
              expense: expenses[index],
              account: account,
              category: category,
            );
          },
        ),
      ),
    );
  }
}
