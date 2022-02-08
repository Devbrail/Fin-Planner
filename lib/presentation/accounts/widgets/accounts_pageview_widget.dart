import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/app/routes.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../common/enum/box_types.dart';
import '../../../common/enum/card_type.dart';
import '../../../common/widgets/empty_widget.dart';
import '../../../data/accounts/model/account.dart';
import '../bloc/accounts_bloc.dart';
import 'account_card.dart';

class AccountPageViewWidget extends StatelessWidget {
  const AccountPageViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Account>>(
      valueListenable:
          Hive.box<Account>(BoxType.accounts.stringValue).listenable(),
      builder: (context, value, _) {
        final accounts = value.values.toList();
        if (accounts.isEmpty) {
          return EmptyWidget(
            icon: Icons.credit_card,
            title: AppLocalizations.of(context)!.errorNoCards,
            description: AppLocalizations.of(context)!.errorNoCardsDescription,
          );
        }
        BlocProvider.of<AccountsBloc>(context)
            .add(AccountSeletedEvent(accounts[0]));
        return AspectRatio(
          aspectRatio: 16 / 10,
          child: PageView.builder(
            itemCount: accounts.length,
            onPageChanged: (index) {
              BlocProvider.of<AccountsBloc>(context)
                  .add(AccountSeletedEvent(accounts[index]));
            },
            itemBuilder: (_, index) {
              final account = accounts[index];
              return AccountCard(
                cardHolder: account.name,
                cardNumber: account.number,
                bankName: account.bankName,
                cardType: account.cardType ?? CardType.debitcard,
                onDelete: () {
                  BlocProvider.of<AccountsBloc>(context)
                      .add(DeleteAccountEvent(account));
                },
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    addAccountCardScreen,
                    arguments: account,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
