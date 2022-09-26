import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../common/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';
import '../bloc/accounts_bloc.dart';
import 'account_card.dart';

class AccountPageViewWidget extends StatelessWidget {
  AccountPageViewWidget({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  final PageController _controller = PageController();
  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: PageView.builder(
            key: const Key('accounts_page_view'),
            controller: _controller,
            padEnds: true,
            itemCount: accounts.length,
            onPageChanged: (index) => BlocProvider.of<AccountsBloc>(context)
                .add(AccountSelectedEvent(accounts[index])),
            itemBuilder: (_, index) {
              final account = accounts[index];
              return AccountCard(
                key: ValueKey(account.hashCode),
                cardHolder: account.name,
                cardNumber: account.number,
                bankName: account.bankName,
                cardType: account.cardType ?? CardType.debitcard,
                onDelete: () => BlocProvider.of<AccountsBloc>(context)
                    .add(DeleteAccountEvent(account)),
                onTap: () => context.goNamed(
                  editAccountPath,
                  params: <String, String>{'aid': account.superId.toString()},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
