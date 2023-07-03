import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../main.dart';
import '../../../core/enum/filter_expense.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../summary/controller/summary_controller.dart';
import '../cubit/budget_cubit.dart';
import '../widgets/filter_budget_widget.dart';
import '../widgets/filter_date_range_widget.dart';
import '../widgets/overview_filter_widget.dart';
import '../widgets/overview_list_widget.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({
    Key? key,
    required this.summaryController,
    required this.budgetCubit,
  }) : super(key: key);

  final BudgetCubit budgetCubit;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    budgetCubit.fetchDefaultCategory();
    return ValueListenableBuilder<Box<ExpenseModel>>(
      valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
      builder: (context, expenseBox, _) {
        return FilterOverviewWidget(
          expenses: expenseBox.values,
          valueNotifier: summaryController.typeNotifier,
          builder: (expenses) {
            return FilterDateRangeWidget(
              dateTimeRangeNotifier: summaryController.dateTimeRangeNotifier,
              expenses: expenses,
              builder: (expenses) {
                return ValueListenableBuilder<FilterExpense>(
                  valueListenable: summaryController.filterExpenseNotifier,
                  builder: (context, value, child) {
                    budgetCubit.fetchBudgetSummary(expenses, value);
                    return Scaffold(
                      body: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          OverviewFilter(
                            budgetCubit: budgetCubit,
                            summaryController: summaryController,
                          ),
                          OverviewListView(budgetCubit: budgetCubit),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
