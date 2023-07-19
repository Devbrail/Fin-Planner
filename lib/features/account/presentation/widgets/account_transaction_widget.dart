import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/config/routes.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/enum/card_type.dart';
import 'package:paisa/core/theme/custom_color.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart';
import 'package:paisa/features/account/presentation/widgets/account_history_widget.dart';
import 'package:paisa/features/transaction/domain/entities/expense.dart';
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart';
import 'package:paisa/src/presentation/summary/widgets/expense_month_card.dart';
import 'package:paisa/src/presentation/summary/widgets/transactions_header_widget.dart';

import 'package:paisa/src/presentation/widgets/paisa_card.dart';
import 'package:paisa/src/presentation/widgets/paisa_empty_widget.dart';
import 'package:paisa/src/presentation/widgets/paisa_expense_stats_widget.dart';
import 'package:provider/provider.dart';

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
