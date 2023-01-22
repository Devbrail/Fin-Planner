import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../service_locator.dart';
import '../../widgets/future_resolve.dart';
import 'expense_month_card.dart';

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({
    super.key,
    required this.valueNotifier,
  });

  final ValueNotifier<FilterBudget> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: locator.get<Box<Expense>>().listenable(),
      builder: (_, value, child) {
        final expenses = value.expenses;
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
                    context.loc.emptyExpensesMessage,
                  ),
                ],
              ),
            ),
          );
        }

        return FutureResolve<List<dynamic>>(
          future: Future.wait([
            locator.getAsync<LocalAccountManagerDataSource>(),
            locator.getAsync<LocalCategoryManagerDataSource>(),
          ]),
          builder: (result) => ValueListenableBuilder<FilterBudget>(
            valueListenable: valueNotifier,
            builder: (_, value, __) {
              final maps = groupBy(
                  expenses, (Expense element) => element.time.formatted(value));
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: maps.entries.length,
                itemBuilder: (_, mapIndex) => ExpenseMonthCardWidget(
                  title: maps.keys.elementAt(mapIndex),
                  total: maps.values.elementAt(mapIndex).filterTotal,
                  expenses: maps.values.elementAt(mapIndex),
                  accountSource: result[0] as LocalAccountManagerDataSource,
                  categorySource: result[1] as LocalCategoryManagerDataSource,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
