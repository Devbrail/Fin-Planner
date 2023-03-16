import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_level_constants.dart';
import '../../../app/routes.dart';
import '../../../core/extensions/account_extension.dart';
import '../../../core/common.dart';
import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/paisa_card.dart';
import 'account_summary_widget.dart';

class AccountCardWidget extends StatelessWidget {
  const AccountCardWidget({
    super.key,
    required this.account,
    required this.expenses,
  });
  final AccountModel account;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PaisaFilledCard(
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
                    style: GoogleFonts.manrope(
                      textStyle:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
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
