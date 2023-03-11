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
              LavaAnimation(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GlassmorphicContainer(
                    height: 156,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: 24,
                    blur: 7,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.1),
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.05),
                      ],
                      stops: const [0.1, 1],
                    ),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.5),
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.5),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.loc.totalBalanceLabel),
                          Text(
                            (totalAccountAmount + totalIncome - totalExpense)
                                .toCurrency(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
