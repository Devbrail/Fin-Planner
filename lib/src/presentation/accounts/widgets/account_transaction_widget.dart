import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/common.dart';
import '../../summary/controller/summary_controller.dart';
import '../../summary/widgets/transactions_header_widget.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/accounts_bloc.dart';
import 'account_history_widget.dart';

class AccountTransactionWidget extends StatelessWidget {
  const AccountTransactionWidget({
    Key? key,
    this.isScroll = false,
  }) : super(key: key);

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
              TransactionsHeaderWidget(
                summaryController: Provider.of<SummaryController>(context),
              ),
              AccountHistoryWidget(
                expenses: state.expenses,
                summaryController: Provider.of<SummaryController>(context),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
