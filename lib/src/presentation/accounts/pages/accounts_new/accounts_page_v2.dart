import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../../main.dart';
import '../../../../core/account_extension.dart';
import '../../../../core/common.dart';
import '../../../../data/accounts/model/account.dart';
import '../../../../data/expense/model/expense.dart';
import '../../../widgets/lava/lava_clock.dart';
import '../../../widgets/multi_value_listenable_builder.dart';
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
      return MultiValueListenableBuilder(
        valueListenables: [
          getIt.get<Box<Expense>>().listenable(),
          getIt.get<Box<Account>>().listenable()
        ],
        builder: (context, values, child) {
          final Box<Expense> expenseValue = values[0];
          final Box<Account> accountValue = values[1];
          final totalIncome = expenseValue.totalIncome;
          final totalExpense = expenseValue.totalExpense;
          final totalAccountAmount = accountValue.totalAccountInitialAmount;
          return ListView(
            children: [
              const SizedBox(height: 8),
              AccountSummaryWidget(expenses: expenseValue.values.toList()),
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 124),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: accounts.length,
                itemBuilder: (context, index) => AccountCardWidget(
                  account: accounts[index],
                  expenses:
                      expenseValue.expensesFromAccountId(accounts[index].key),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
