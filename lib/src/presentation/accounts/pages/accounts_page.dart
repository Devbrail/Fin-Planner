import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/src/app/app_level_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/common.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/expense/model/expense.dart';
import '../../../service_locator.dart';
import '../../widgets/future_resolve.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/accounts_bloc.dart';
import 'accounts_mobile_page.dart';
import 'accounts_new/accounts_new_page.dart';
import 'accounts_tablet_page.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureResolve<AccountsBloc>(
      future: locator.getAsync<AccountsBloc>(),
      builder: (accountsBloc) => Material(
        key: const Key('accounts_mobile'),
        child: ValueListenableBuilder<Box<Account>>(
          valueListenable: locator.get<Box<Account>>().listenable(),
          builder: (_, value, __) {
            final List<Account> accounts = value.values.toList();
            if (useAccountsList) {
              return NewAccountsPage(accounts: accounts);
            }
            if (accounts.isEmpty) {
              return EmptyWidget(
                icon: Icons.credit_card,
                title: context.loc.errorNoCardsLabel,
                description: context.loc.errorNoCardsDescriptionLabel,
              );
            }
            accountsBloc.add(AccountSelectedEvent(accounts.first));
            return BlocBuilder(
              bloc: accountsBloc,
              builder: (context, state) {
                if (state is AccountSelectedState) {
                  return ValueListenableBuilder<Box<Expense>>(
                    valueListenable: locator.get<Box<Expense>>().listenable(),
                    builder: (context, value, child) {
                      final expenses = value.allAccount(state.account.key);

                      return ScreenTypeLayout(
                        mobile: AccountsMobilePage(
                          accounts: accounts,
                          accountsBloc: accountsBloc,
                          expenses: expenses,
                        ),
                        tablet: AccountsTabletPage(
                          accounts: accounts,
                          accountsBloc: accountsBloc,
                          expenses: expenses,
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
