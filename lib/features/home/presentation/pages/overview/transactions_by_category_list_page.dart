import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/transaction/domain/entities/expense.dart';
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart';
import 'package:paisa/src/presentation/summary/widgets/expense_item_widget.dart';
import 'package:paisa/src/presentation/widgets/paisa_annotate_region_widget.dart';
import 'package:paisa/src/presentation/widgets/paisa_card.dart';

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
      color: Colors.transparent,
      child: Scaffold(
        extendBody: true,
        appBar: context.materialYouAppBar(context.loc.transactionsByCategory),
        bottomNavigationBar: SafeArea(
          child: PaisaFilledCard(
            child: ListTile(
              title: Text(
                context.loc.total,
                style: context.titleSmall
                    ?.copyWith(color: context.onSurfaceVariant),
              ),
              subtitle: Text(
                expenses.total.toFormateCurrency(context),
                style: context.titleMedium?.copyWith(
                  color: context.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
