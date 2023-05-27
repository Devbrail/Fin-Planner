import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/accounts/data_sources/local_account_data_manager.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../summary/widgets/transactions_header_widget.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/accounts_bloc.dart';
import 'account_history_widget.dart';

class AccountTransactionWidget extends StatelessWidget {
  const AccountTransactionWidget({
    Key? key,
    required this.accountLocalDataSource,
    required this.categoryLocalDataSource,
    this.isScroll = false,
  }) : super(key: key);

  final LocalAccountDataManager accountLocalDataSource;
  final LocalCategoryManagerDataSource categoryLocalDataSource;

  final bool isScroll;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is AccountSelectedState) {
          if (state.expenses.isEmpty) {
            return EmptyWidget(
              title: context.loc.emptyExpensesMessageTitle,
              icon: Icons.money_off_rounded,
              description: context.loc.emptyExpensesMessageTitle,
            );
          }
          return ListView(
            physics: isScroll ? null : const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              TransactionsHeaderWidget(summaryController: getIt.get()),
              AccountHistoryWidget(expenses: state.expenses)
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
