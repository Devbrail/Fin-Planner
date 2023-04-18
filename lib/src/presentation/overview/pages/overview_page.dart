import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/controller/summary_controller.dart';
import '../../widgets/paisa_chip.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../cubit/budget_cubit.dart';
import '../widgets/category_list_widget.dart';
import '../widgets/filter_date_range_widget.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BudgetCubit budgetCubit = getIt.get();
    final SummaryController summaryController = getIt.get();
    return ValueListenableBuilder<Box<ExpenseModel>>(
      valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
      builder: (context, value, _) {
        final List<Expense> expenses = value.budgetOverView.toEntities();
        if (expenses.isEmpty) {
          return EmptyWidget(
            icon: Icons.paid,
            title: context.loc.errorNoBudgetLabel,
            description: context.loc.errorNoBudgetDescriptionLabel,
          );
        }
        return FilterDateRangeWidget(
          dateTimeRangeNotifier: summaryController.dateTimeRangeNotifier,
          expenses: expenses,
          builder: (expenses) {
            if (expenses.isEmpty) {
              return EmptyWidget(
                icon: Icons.paid,
                title: context.loc.errorNoBudgetLabel,
                description: context.loc.errorNoBudgetDescriptionLabel,
              );
            }
            return ValueListenableBuilder<FilterExpense>(
              valueListenable: summaryController.filterExpenseNotifier,
              builder: (context, value, child) {
                budgetCubit.fetchBudgetSummary(expenses, value);
                return Scaffold(
                  body: ListView(
                    padding: const EdgeInsets.only(bottom: 124),
                    shrinkWrap: true,
                    children: [
                      BlocBuilder(
                        bloc: budgetCubit,
                        buildWhen: (previous, current) =>
                            current is InitialSelectedState,
                        builder: (context, state) {
                          if (state is InitialSelectedState) {
                            return SizedBox(
                              height: 80,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(16),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.filerTimes.length,
                                itemBuilder: (context, index) {
                                  final item = state.filerTimes[index];
                                  return PaisaMaterialYouChip(
                                    title: item,
                                    onPressed: () {
                                      if (budgetCubit.selectedTime != item) {
                                        budgetCubit.updateFilterTime(item);
                                      }
                                    },
                                    isSelected:
                                        item == budgetCubit.selectedTime,
                                  );
                                },
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      BlocBuilder(
                        bloc: budgetCubit,
                        buildWhen: (previous, current) =>
                            current is FilteredCategoryListState,
                        builder: (context, state) {
                          if (state is FilteredCategoryListState) {
                            return CategoryListWidget(
                              categoryGrouped: state.categoryGrouped,
                              totalExpense: state.totalExpense,
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
