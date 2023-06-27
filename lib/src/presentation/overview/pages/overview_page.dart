import 'package:bezier_chart_plus/bezier_chart_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/filter_expense.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/controller/summary_controller.dart';
import '../../widgets/paisa_card.dart';
import '../cubit/budget_cubit.dart';
import '../widgets/filter_budget_widget.dart';
import '../widgets/filter_date_range_widget.dart';
import '../widgets/overview_filter_widget.dart';
import '../widgets/overview_list_widget.dart';

enum OverviewType { income, expense }

class TransactionTypeSegmentedWidget extends StatelessWidget {
  const TransactionTypeSegmentedWidget({
    super.key,
    required this.summaryController,
  });

  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ValueListenableBuilder<OverviewType>(
        valueListenable: summaryController.typeNotifier,
        builder: (context, type, child) {
          return SegmentedButton<OverviewType>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment<OverviewType>(
                value: OverviewType.income,
                label: Text(context.loc.income),
              ),
              ButtonSegment<OverviewType>(
                value: OverviewType.expense,
                label: Text(context.loc.expense),
              ),
            ],
            selected: <OverviewType>{type},
            onSelectionChanged: (newSelection) {
              summaryController.typeNotifier.value = newSelection.first;
            },
          );
        },
      ),
    );
  }
}

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

class BarChartSample2 extends StatefulWidget {
  const BarChartSample2({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final List<DataPoint> expensePoints = [];
  final List<DataPoint> incomePoints = [];
  late DateTime selectedDate = toDate;
  final DateTime toDate = DateTime.now();

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
            bubbleIndicatorColor: context.surface,
            bubbleIndicatorValueStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: context.primary),
            bubbleIndicatorTitleStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: context.onSurface),
            bubbleIndicatorLabelStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: context.onSurface),
            verticalIndicatorStrokeWidth: 2.0,
            showVerticalIndicator: true,
            contentWidth: MediaQuery.of(context).size.width * 2,
            footerHeight: 50.0,
            xLinesColor: context.primary,
            verticalIndicatorColor: context.primary,
          ),
        ),
      ),
    );
  }
}
