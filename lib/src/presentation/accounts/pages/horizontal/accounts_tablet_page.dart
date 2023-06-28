import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/account/entities/account.dart';
import '../../bloc/accounts_bloc.dart';
import '../../widgets/account_summary_widget.dart';
import '../../widgets/account_transaction_widget.dart';
import '../../widgets/accounts_page_view_widget.dart';

class AccountsHorizontalTabletPage extends StatelessWidget {
  const AccountsHorizontalTabletPage({
    super.key,
    required this.accounts,
  });

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AccountPageViewWidget(accounts: accounts),
              BlocBuilder<AccountsBloc, AccountsState>(
                builder: (context, state) {
                  if (state is AccountSelectedState) {
                    return AccountSummaryWidget(expenses: state.expenses);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
        const Expanded(
          child: AccountTransactionWidget(
            isScroll: true,
          ),
        ),
      ],
    );
  }
}
