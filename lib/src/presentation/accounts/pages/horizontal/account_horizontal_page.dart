import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../domain/account/entities/account.dart';
import '../../bloc/accounts_bloc.dart';
import 'accounts_mobile_page.dart';
import 'accounts_tablet_page.dart';

class AccountMobileHorizontalPage extends StatelessWidget {
  const AccountMobileHorizontalPage({
    super.key,
    required this.accounts,
  });

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AccountsBloc>(context)
        .add(AccountSelectedEvent(accounts.first));
    return ScreenTypeLayout(
      mobile: AccountsHorizontalMobilePage(accounts: accounts),
      tablet: AccountsHorizontalTabletPage(accounts: accounts),
    );
  }
}
