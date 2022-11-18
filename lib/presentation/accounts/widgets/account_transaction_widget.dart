import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../summary/widgets/expense_item_widget.dart';
import '../../widgets/paisa_card.dart';

class AccountTransactionWidget extends StatelessWidget {
  const AccountTransactionWidget({
    Key? key,
    required this.accountLocalDataSource,
    required this.categoryLocalDataSource,
    required this.expenses,
  }) : super(key: key);

  final AccountLocalDataSource accountLocalDataSource;
  final CategoryLocalDataSource categoryLocalDataSource;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.money_off_rounded, size: 72),
              Text(AppLocalizations.of(context)!.emptyExpensesMessage),
            ],
          ),
        ),
      );
    }
    return ScreenTypeLayout(
      mobile: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              AppLocalizations.of(context)!.transactionHistoryLabel,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PaisaCard(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                itemBuilder: (_, index) {
                  return ExpenseItemWidget(
                    expense: expenses[index],
                    account: accountLocalDataSource
                        .fetchAccount(expenses[index].accountId),
                    category: categoryLocalDataSource
                        .fetchCategory(expenses[index].categoryId),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      tablet: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              AppLocalizations.of(context)!.transactionHistoryLabel,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PaisaCard(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: expenses.length,
                itemBuilder: (_, index) {
                  return ExpenseItemWidget(
                    expense: expenses[index],
                    account: accountLocalDataSource
                        .fetchAccount(expenses[index].accountId),
                    category: categoryLocalDataSource
                        .fetchCategory(expenses[index].categoryId),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
