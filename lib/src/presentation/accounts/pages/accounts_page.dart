import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../app/app_level_constants.dart';
import '../../../core/common.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/accounts_bloc.dart';
import 'accounts_mobile_page.dart';
import 'accounts_new/accounts_page_v2.dart';
import 'accounts_tablet_page.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountsBloc accountsBloc = getIt.get();
    return Scaffold(
      key: const Key('accounts_mobile'),
      body: ValueListenableBuilder<Box<AccountModel>>(
        valueListenable: getIt.get<Box<AccountModel>>().listenable(),
        builder: (_, value, __) {
          final List<Account> accounts = value.toEntities();
          if (useAccountsList) {
            return AccountsPageV2(
              accounts: accounts,
              accountsBloc: accountsBloc,
            );
          } else {
            if (accounts.isEmpty) {
              return EmptyWidget(
                icon: Icons.credit_card,
                title: context.loc.emptyAccountLabel,
                description: context.loc.emptyAccountDescriptionLabel,
              );
            }
            accountsBloc.add(AccountSelectedEvent(accounts.first));
            return BlocBuilder(
              bloc: accountsBloc,
              buildWhen: (previous, current) => current is AccountSelectedState,
              builder: (context, state) {
                if (state is AccountSelectedState) {
                  final List<Expense> expenses = accountsBloc
                      .fetchExpenseFromAccountId(state.account.superId!);
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
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }
        },
      ),
    );
  }
}
