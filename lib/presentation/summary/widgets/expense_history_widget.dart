import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../common/common.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import '../cubit/summary_cubit.dart';
import 'expense_month_card.dart';

class ExpenseHistory extends StatefulWidget {
  const ExpenseHistory({Key? key}) : super(key: key);

  @override
  State<ExpenseHistory> createState() => _ExpenseHistoryState();
}

class _ExpenseHistoryState extends State<ExpenseHistory> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: locator.get<Box<Expense>>().listenable(),
      builder: (_, value, child) {
        final expenses = value.values.toList();
        if (expenses.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.money_off_rounded,
                    size: 72,
                  ),
                  Text(
                    AppLocalizations.of(context)!.emptyExpensesMessage,
                  ),
                ],
              ),
            ),
          );
        }
        expenses.sort(((a, b) => b.time.compareTo(a.time)));
        return BlocBuilder(
          bloc: BlocProvider.of<SummaryCubit>(context),
          builder: (context, state) {
            if (state is SummaryFilterBudgetState) {
              final maps = groupBy(expenses,
                  (Expense element) => element.time.formatted(state.budget));
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: maps.entries.length,
                itemBuilder: (_, mapIndex) {
                  final expenses = maps.values.toList()[mapIndex];
                  expenses.sort((a, b) => b.time.compareTo(a.time));
                  return ExpenseMonthCardWidget(
                    title: maps.keys.toList()[mapIndex],
                    total: expenses.filterTotal,
                    expenses: expenses,
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
