import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/accounts/model/account.dart';
import '../../../di/service_locator.dart';
import '../bloc/accounts_bloc.dart';
import '../widgets/account_transaction_widget.dart';
import '../widgets/accounts_pageview_widget.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('accounts')
      .withConverter<Account>(
        fromFirestore: (snapshots, _) => Account.fromJson(snapshots.data()!),
        toFirestore: (expense, _) => expense.toJson(),
      );

  final AccountsBloc accountsBloc = locator.get();
  int selectedIndex = 0;
  Account? selectedAccount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => accountsBloc,
      child: ScreenTypeLayout(
        mobile: Scaffold(
          appBar: materialYouAppBar(
            context,
            AppLocalizations.of(context)!.accounts,
          ),
          body: ListView(
            padding: const EdgeInsets.only(
              bottom: 124,
            ),
            children: [
              AccountPageViewWidget(),
              BlocBuilder(
                bloc: accountsBloc,
                buildWhen: (previous, current) =>
                    current is AccountSeletedState,
                builder: (context, state) {
                  if (state is AccountSeletedState) {
                    return AccountTransactinWidget(account: state.account);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.large(
            onPressed: () => Navigator.pushNamed(context, addAccountCardScreen),
            heroTag: 'add_account',
            key: const Key('add_account'),
            tooltip: AppLocalizations.of(context)!.addAccount,
            child: const Icon(Icons.add),
          ),
        ),
        tablet: Scaffold(
          appBar: materialYouAppBar(
            context,
            AppLocalizations.of(context)!.accounts,
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: AccountPageViewWidget()),
              Expanded(
                child: BlocBuilder(
                  bloc: accountsBloc,
                  buildWhen: (previous, current) =>
                      current is AccountSeletedState,
                  builder: (context, state) {
                    if (state is AccountSeletedState) {
                      return AccountTransactinWidget(account: state.account);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.large(
            onPressed: () => Navigator.pushNamed(context, addAccountCardScreen),
            heroTag: 'add_account',
            key: const Key('add_account'),
            tooltip: AppLocalizations.of(context)!.addAccount,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
