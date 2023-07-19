import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/routes.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/enum/card_type.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/transaction/domain/entities/expense.dart';
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart';
import 'package:paisa/src/presentation/summary/widgets/expense_month_card.dart';

import 'package:paisa/src/presentation/widgets/paisa_card.dart';
import 'package:paisa/src/presentation/widgets/paisa_empty_widget.dart';

class AccountHistoryWidget extends StatelessWidget {
  const AccountHistoryWidget({
    super.key,
    required this.expenses,
    required this.summaryController,
  });

  final List<Expense> expenses;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return EmptyWidget(
        title: context.loc.emptyExpensesMessageTitle,
        icon: Icons.money_off_rounded,
        description: context.loc.emptyExpensesMessageSubTitle,
      );
    } else {
      return ValueListenableBuilder<FilterExpense>(
        valueListenable: summaryController.sortHomeExpenseNotifier,
        builder: (_, value, __) {
          final maps = groupBy(
              expenses, (Expense element) => element.time.formatted(value));
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: maps.entries.length,
            itemBuilder: (_, mapIndex) => ExpenseMonthCardWidget(
              title: maps.keys.elementAt(mapIndex),
              total: maps.values.elementAt(mapIndex).filterTotal,
              expenses: maps.values.elementAt(mapIndex),
            ),
          );
        },
      );
    }
  }
}
