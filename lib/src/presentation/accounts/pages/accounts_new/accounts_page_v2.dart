import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../../data/expense/model/expense_model.dart';
import '../../../../domain/account/entities/account.dart';
import '../../../../domain/expense/entities/expense.dart';
import '../../../widgets/paisa_empty_widget.dart';
import '../../bloc/accounts_bloc.dart';
import '../../widgets/account_card_v2.dart';

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
        title: context.loc.emptyAccountLabel,
        description: context.loc.emptyAccountDescriptionLabel,
      );
    } else {
      return ValueListenableBuilder<Box<ExpenseModel>>(
        valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
        builder: (context, value, child) {
          return ListView(
            children: [
              const SizedBox(height: 8),
              ScreenTypeLayout(
                mobile: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 124),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final List<Expense> expenses = value
                        .expensesFromAccountId(accounts[index].superId!)
                        .map((e) => e.toEntity())
                        .toList();
                    return AccountCardV2(
                      account: accounts[index],
                      expenses: expenses,
                    );
                  },
                ),
                tablet: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 124),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: accounts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    final List<Expense> expenses = value
                        .expensesFromAccountId(accounts[index].key)
                        .map((e) => e.toEntity())
                        .toList();
                    return AccountCardV2(
                      account: accounts[index],
                      expenses: expenses,
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
