import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/paisa_card.dart';

class AccountCardV2 extends StatelessWidget {
  const AccountCardV2({
    super.key,
    required this.account,
    required this.expenses,
  });

  final AccountModel account;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(seedColor: Color(account.color!));
    final color = colorScheme.primaryContainer;
    final onPrimary = colorScheme.onPrimaryContainer;
    final String expense = expenses.totalExpense.toFormateCurrency(context);
    final String income = expenses.totalIncome.toFormateCurrency(context);
    final String totalBalance =
        (account.initialAmount + expenses.fullTotal).toFormateCurrency(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PaisaFilledCard(
          color: color,
          child: InkWell(
            onTap: () => GoRouter.of(context).pushNamed(
              accountTransactionName,
              pathParameters: <String, String>{
                'aid': account.superId.toString()
              },
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
                    color: onPrimary,
                  ),
                  title: Text(
                    account.name,
                    style: GoogleFonts.outfit(
                      textStyle: context.bodyMedium?.copyWith(
                        color: onPrimary,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    account.bankName,
                    style: GoogleFonts.outfit(
                      textStyle: context.bodyMedium?.copyWith(
                        color: onPrimary.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    totalBalance,
                    style: GoogleFonts.manrope(
                      textStyle: context.headlineSmall?.copyWith(
                        color: onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    context.loc.thisMonth,
                    style: context.titleMedium?.copyWith(
                      color: onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ThisMonthTransactionWidget(
                        title: context.loc.income,
                        content: income,
                        color: onPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ThisMonthTransactionWidget(
                        title: context.loc.expense,
                        color: onPrimary,
                        content: expense,
                      ),
                    ),
                  ],
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

class ThisMonthTransactionWidget extends StatelessWidget {
  const ThisMonthTransactionWidget({
    super.key,
    required this.title,
    required this.content,
    required this.color,
  });

  final Color color;
  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              textStyle: TextStyle(
                color: color.withOpacity(0.75),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: GoogleFonts.manrope(
              textStyle: context.titleLarge?.copyWith(
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
