import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/common.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/expense/model/expense.dart';
import '../../../service_locator.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/accounts_bloc.dart';
import '../widgets/account_summary_widget.dart';
import '../widgets/account_transaction_widget.dart';
import '../widgets/accounts_page_view_widget.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AccountsBloc>(
      future: locator.getAsync<AccountsBloc>(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final AccountsBloc accountsBloc = snapshot.data!;
          return Scaffold(
            key: const Key('accounts_mobile'),
            appBar: context.materialYouAppBar(
              AppLocalizations.of(context)!.accountsLabel,
            ),
            body: ValueListenableBuilder<Box<Account>>(
              valueListenable: locator.get<Box<Account>>().listenable(),
              builder: (_, value, __) {
                final List<Account> accounts = value.values.toList();
                if (accounts.isEmpty) {
                  return EmptyWidget(
                    icon: Icons.credit_card,
                    title: AppLocalizations.of(context)!.errorNoCardsLabel,
                    description: AppLocalizations.of(context)!
                        .errorNoCardsDescriptionLabel,
                  );
                }
                accountsBloc.add(AccountSelectedEvent(accounts[0]));
                return BlocBuilder(
                  bloc: accountsBloc,
                  builder: (context, state) {
                    if (state is AccountSelectedState) {
                      return ValueListenableBuilder<Box<Expense>>(
                          valueListenable:
                              locator.get<Box<Expense>>().listenable(),
                          builder: (context, value, child) {
                            final expenses =
                                value.allAccount(state.account.key);
                            expenses.sort((a, b) => b.time.compareTo(a.time));

                            return ScreenTypeLayout(
                              mobile: ListView(
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
                              tablet: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
