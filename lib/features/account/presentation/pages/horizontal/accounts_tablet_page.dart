import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart';
import 'package:paisa/features/account/presentation/widgets/account_transaction_widget.dart';
import 'package:paisa/features/account/presentation/widgets/accounts_page_view_widget.dart';

class AccountsHorizontalTabletPage extends StatelessWidget {
  const AccountsHorizontalTabletPage({
    super.key,
    required this.accounts,
  });

  final List<AccountEntity> accounts;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AccountPageViewWidget(accounts: accounts),
              BlocBuilder<AccountBloc, AccountState>(
                builder: (BuildContext context, AccountState state) {
                  if (state is AccountSelectedState) {
                    return const SizedBox
                        .shrink(); // return AccountSummaryWidget(transactions: state.expenses);
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
