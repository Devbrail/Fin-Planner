import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/app/app_level_constants.dart';

import '../../../../app/routes.dart';
import '../../../../core/common.dart';
import '../../../../core/enum/card_type.dart';
import '../../../../data/accounts/model/account.dart';
import '../../../../data/expense/model/expense.dart';
import '../../../../service_locator.dart';
import '../../../widgets/paisa_card.dart';
import '../../widgets/account_summary_widget.dart';

class NewAccountsPage extends StatelessWidget {
  const NewAccountsPage({
    super.key,
    required this.accounts,
  });

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final Account account = accounts[index];
        final expenses = locator.get<Box<Expense>>().allAccount(account.key);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: PaisaCard(
              child: InkWell(
                onTap: () => GoRouter.of(context).goNamed(
                  editAccountPath,
                  params: <String, String>{'aid': account.superId.toString()},
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Icon(
                            account.cardType == null
                                ? CardType.bank.icon
                                : account.cardType!.icon,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            account.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Text(
                        expenses.fullTotal.toCurrency(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.75),
                            ),
                      ),
                    ),
                    Spacer(),
                    AccountSummaryWidget(
                      expenses: expenses,
                      useAccountsList: useAccountsList,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
