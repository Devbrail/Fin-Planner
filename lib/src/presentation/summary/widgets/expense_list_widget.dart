import 'package:flutter/material.dart';
import 'package:paisa/src/presentation/widgets/paisa_card.dart';

import '../../../../main.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../controller/summary_controller.dart';
import 'expense_item_widget.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final SummaryController summaryController = getIt.get();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: PaisaCard(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: expenses.length,
          itemBuilder: (_, index) {
            final Expense expense = expenses[index];
            final Account? account =
                summaryController.getAccount(expenses[index].accountId);
            final Category? category =
                summaryController.getCategory(expenses[index].categoryId);
            if (account == null || category == null) {
              return const SizedBox.shrink();
            }
            return ExpenseItemWidget(
              expense: expense,
              account: account,
              category: category,
            );
          },
        ),
      ),
    );
  }
}
