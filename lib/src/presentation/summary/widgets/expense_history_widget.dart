import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/main.dart';
import 'package:paisa/src/presentation/summary/cubit/summary_cubit.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/expense/model/expense.dart';
import 'expense_month_card.dart';

class ExpenseHistory extends StatelessWidget {
  ExpenseHistory({
    super.key,
    required this.valueNotifier,
  });

  final ValueNotifier<FilterBudget> valueNotifier;
  final SummaryCubit summaryCubit = getIt.get<SummaryCubit>()..fetchExpenses();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: summaryCubit,
      builder: (context, state) {
        if (state is SummaryExpenses) {
          if (state.expenses.isEmpty) {
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
                      context.loc.emptyExpensesMessage,
                    ),
                  ],
                ),
              ),
            );
          }
          return ValueListenableBuilder<FilterBudget>(
            valueListenable: valueNotifier,
            builder: (_, value, __) {
              final maps = groupBy(state.expenses,
                  (Expense element) => element.time.formatted(value));
              return ListView.builder(
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
        return Text('data');
      },
    );
  }
}
