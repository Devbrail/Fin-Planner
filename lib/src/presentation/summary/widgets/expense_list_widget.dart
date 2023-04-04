import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../core/enum/card_type.dart';

import '../../../../main.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/paisa_card.dart';
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
              return ExpenseItemWidget(
                expense: expense,
                account: Account(
                  name: 'Transfer',
                  icon: Icons.wallet.codePoint,
                  bankName: 'Transfer bank name',
                  number: 'Transfer bank number',
                  cardType: CardType.bank,
                  amount: 0,
                ),
                category: Category(
                  icon: MdiIcons.bankTransfer.codePoint,
                  name: 'Transfer category',
                  color: Colors.amber.value,
                ),
              );
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
