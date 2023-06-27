import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../../data/expense/model/expense_model.dart';
import '../../../../domain/account/entities/account.dart';
import '../../../../domain/expense/entities/expense.dart';
import '../../widgets/account_card_v2.dart';

class AccountMobileVerticalPage extends StatelessWidget {
  const AccountMobileVerticalPage({super.key, required this.accounts});

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ExpenseModel>>(
      valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
      builder: (context, value, child) {
        return ScreenTypeLayout(
          mobile: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 124),
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
            shrinkWrap: true,
            itemCount: accounts.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 450,
              childAspectRatio: 16 / 11,
            ),
            itemBuilder: (BuildContext context, int index) {
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
        );
      },
    );
  }
}
