import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../../data/accounts/model/account.dart';
import '../../../../data/expense/model/expense.dart';
import '../../../widgets/paisa_empty_widget.dart';
import '../../bloc/accounts_bloc.dart';
import '../../widgets/acccount_card_widget.dart';
import '../../widgets/account_summary_widget.dart';

class AccountsPageV2 extends StatelessWidget {
  const AccountsPageV2({
    super.key,
    required this.accounts,
    required this.accountsBloc,
  });

  final List<Account> accounts;
  final AccountsBloc accountsBloc;

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return EmptyWidget(
        icon: Icons.credit_card,
        title: context.loc.errorNoCardsLabel,
        description: context.loc.errorNoCardsDescriptionLabel,
      );
    } else {
      return ValueListenableBuilder<Box<Expense>>(
        valueListenable: getIt.get<Box<Expense>>().listenable(),
        builder: (context, value, child) {
          return ListView(
            children: [
              const SizedBox(height: 8),
              AccountSummaryWidget(expenses: value.values.toList()),
              ScreenTypeLayout.builder(
                mobile: (_) => ListView.builder(
                  padding: const EdgeInsets.only(bottom: 124),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: accounts.length,
                  itemBuilder: (context, index) => AccountCardWidget(
                    account: accounts[index],
                    expenses: value.expensesFromAccountId(accounts[index].key),
                  ),
                ),
                tablet: (_) => GridView.builder(
                  padding: const EdgeInsets.only(bottom: 124),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: accounts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) =>
                      AccountCardWidget(
                    account: accounts[index],
                    expenses: value.expensesFromAccountId(accounts[index].key),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
