import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/main.dart';
import 'package:paisa/src/app/app_level_constants.dart';
import 'package:paisa/src/app/routes.dart';
import 'package:paisa/src/core/account_extension.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/core/enum/card_type.dart';
import 'package:paisa/src/data/accounts/model/account.dart';
import 'package:paisa/src/data/expense/model/expense.dart';
import 'package:paisa/src/presentation/accounts/widgets/account_summary_widget.dart';

import '../../widgets/paisa_card.dart';

class AccountCardWidget extends StatelessWidget {
  const AccountCardWidget({
    super.key,
    required this.account,
  });
  final Account account;

  @override
  Widget build(BuildContext context) {
    final expenses = getIt.get<Box<Expense>>().allAccount(account.key);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PaisaCard(
          child: InkWell(
            onTap: () => GoRouter.of(context).goNamed(
              accountTransactionPath,
              params: <String, String>{'aid': account.superId.toString()},
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  trailing: Icon(
                    account.cardType == null
                        ? CardType.bank.icon
                        : account.cardType!.icon,
                  ),
                  title: Text(
                    account.name,
                  ),
                  subtitle: Text(account.bankName),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    (account.initialAmount + expenses.fullTotal).toCurrency(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    context.loc.thisMonthLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.85),
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                AccountSummaryWidget(
                  expenses: expenses,
                  useAccountsList: useAccountsList,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
