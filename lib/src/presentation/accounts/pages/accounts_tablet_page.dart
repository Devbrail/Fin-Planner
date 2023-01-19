import 'package:flutter/material.dart';

import '../../../data/accounts/model/account.dart';
import '../../../data/expense/model/expense.dart';
import '../../../service_locator.dart';
import '../bloc/accounts_bloc.dart';
import '../widgets/account_summary_widget.dart';
import '../widgets/account_transaction_widget.dart';
import '../widgets/accounts_page_view_widget.dart';

class AccountsTabletPage extends StatelessWidget {
  const AccountsTabletPage({
    super.key,
    required this.accounts,
    required this.accountsBloc,
    required this.expenses,
  });

  final List<Account> accounts;
  final List<Expense> expenses;
  final AccountsBloc accountsBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AccountPageViewWidget(
                accountBloc: accountsBloc,
                accounts: accounts,
              ),
              AccountSummaryWidget(expenses: expenses)
            ],
          ),
        ),
        Expanded(
          child: AccountTransactionWidget(
            accountLocalDataSource: locator.get(),
            categoryLocalDataSource: locator.get(),
            expenses: expenses,
            isScroll: true,
          ),
        ),
      ],
    );
  }
}
