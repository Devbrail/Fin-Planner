import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../widgets/paisa_search_button_widget.dart';

import '../../../data/accounts/model/account.dart';
import '../../../data/expense/model/expense.dart';
import '../../../service_locator.dart';
import '../../widgets/menu_icon_widget.dart';
import '../../widgets/paisa_title_widget.dart';
import '../../widgets/paisa_user_widget.dart';
import '../bloc/accounts_bloc.dart';
import '../widgets/account_summary_widget.dart';
import '../widgets/account_transaction_widget.dart';
import '../widgets/accounts_page_view_widget.dart';

class AccountsMobilePage extends StatelessWidget {
  const AccountsMobilePage({
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
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        key: const Key('accounts_list_view'),
        padding: const EdgeInsets.only(bottom: 124),
        children: [
          AccountPageViewWidget(
            accounts: accounts,
            accountBloc: accountsBloc,
          ),
          AccountSummaryWidget(expenses: expenses),
          AccountTransactionWidget(
            accountLocalDataSource: locator.get(),
            categoryLocalDataSource: locator.get(),
            expenses: expenses,
          )
        ],
      ),
    );
  }
}
