import 'package:flutter/material.dart';

import '../../../../domain/account/entities/account.dart';
import '../../widgets/account_transaction_widget.dart';
import '../../widgets/accounts_page_view_widget.dart';

class AccountsHorizontalMobilePage extends StatelessWidget {
  const AccountsHorizontalMobilePage({super.key, required this.accounts});

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      key: const Key('accounts_list_view'),
      padding: const EdgeInsets.only(bottom: 124),
      children: [
        AccountPageViewWidget(accounts: accounts),
        const AccountTransactionWidget()
      ],
    );
  }
}
