import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/data/accounts/datasources/account_data_source.dart';
import 'package:flutter_paisa/di/service_locator.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../common/enum/box_types.dart';
import '../../../common/constants/extensions.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/expense/model/expense.dart';
import '../../summary/widgets/expense_item_widget.dart';

class AccountTransactinWidget extends StatelessWidget {
  const AccountTransactinWidget({
    Key? key,
    required this.account,
  }) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable:
          Hive.box<Expense>(BoxType.expense.stringValue).listenable(),
      builder: (context, value, child) {
        final expenses = value.allAccount(account.superId!);
        if (expenses.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                AppLocalizations.of(context)!.transactionHistory,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: MaterialYouCard(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: expenses.length,
                  itemBuilder: (_, index) {
                    return ExpensItemWidget(
                      expense: expenses[index],
                      account: locator
                          .get<AccountDataSource>()
                          .fetchAccount(expenses[index].accountId),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
