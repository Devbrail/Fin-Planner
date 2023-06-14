import 'package:bezier_chart_plus/bezier_chart_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:paisa/src/presentation/widgets/filter_widget/paisa_filter_transaction_widget.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/filter_expense.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/controller/summary_controller.dart';
import '../../widgets/paisa_card.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../../widgets/paisa_pill_chip.dart';
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
      builder: (context, expenseBox, _) {
        final List<Expense> expenses = expenseBox.budgetOverView.toEntities();
        if (expenses.isEmpty) {
          return EmptyWidget(
            icon: Icons.paid,
            title: context.loc.emptyOverviewMessageTitle,
            description: context.loc.emptyOverviewMessageSubtitle,
          );
        }
        return FilterDateRangeWidget(
          dateTimeRangeNotifier: summaryController.dateTimeRangeNotifier,
          expenses: expenses,
          builder: (expenses) {
            if (expenses.isEmpty) {
              return EmptyWidget(
                icon: Icons.paid,
                title: context.loc.emptyOverviewMessageTitle,
                description: context.loc.emptyOverviewMessageSubtitle,
              );
            }
            return ValueListenableBuilder<FilterExpense>(
              valueListenable: summaryController.filterExpenseNotifier,
              builder: (context, value, child) {
                budgetCubit.fetchBudgetSummary(expenses, value);
                return Scaffold(
                  body: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      BlocBuilder(
                        bloc: budgetCubit,
                        buildWhen: (previous, current) =>
                            current is InitialSelectedState,
                        builder: (context, state) {
                          if (state is InitialSelectedState) {
                            return SizedBox(
                              height: 70,
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  const PaisaFilterTransactionWidget(),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.all(16),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.filerTimes.length,
                                      itemBuilder: (context, index) {
                                        final item = state.filerTimes[index];
                                        return PaisaPillChip(
                                          title: item,
                                          onPressed: () {
                                            if (budgetCubit.selectedTime !=
                                                item) {
                                              budgetCubit
                                                  .updateFilterTime(item);
                                            }
                                          },
                                          isSelected:
                                              item == budgetCubit.selectedTime,
                                        );
                                      },
                                    ),
                                  ),
                                ],
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

class BarChartSample2 extends StatefulWidget {
  const BarChartSample2({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final DateTime toDate = DateTime.now();
  late DateTime selectedDate = toDate;
  final List<DataPoint> incomePoints = [];
  final List<DataPoint> expensePoints = [];
  @override
  void initState() {
    super.initState();
    expensePoints.addAll(widget.expenses.expenseList
        .map((e) => DataPoint<DateTime>(value: e.currency, xAxis: e.time)));
    incomePoints.addAll(widget.expenses.incomeList
        .map((e) => DataPoint<DateTime>(value: e.currency, xAxis: e.time)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PaisaFilledCard(
        child: BezierChart(
          bezierChartScale: BezierChartScale.monthly,
          fromDate: widget.expenses.last.time,
          toDate: toDate,
          selectedDate: selectedDate,
          onValueSelected: (value) {
            debugPrint(value.toString());
          },
          onScaleChanged: (value) {},
          onDateTimeSelected: (value) {},
          series: [
            BezierLine(
              label: context.loc.expense,
              data: expensePoints,
              lineColor: Colors.red.shade300,
            ),
            BezierLine(
              label: context.loc.income,
              data: incomePoints,
              lineColor: Colors.green.shade300,
            ),
          ],
          config: BezierChartConfig(
            bubbleIndicatorColor: Theme.of(context).colorScheme.surface,
            bubbleIndicatorValueStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.primary),
            bubbleIndicatorTitleStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
            bubbleIndicatorLabelStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
            verticalIndicatorStrokeWidth: 2.0,
            showVerticalIndicator: true,
            contentWidth: MediaQuery.of(context).size.width * 2,
            footerHeight: 50.0,
            xLinesColor: Theme.of(context).colorScheme.primary,
            verticalIndicatorColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
