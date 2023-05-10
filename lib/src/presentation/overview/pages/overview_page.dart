import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:paisa/src/core/enum/transaction.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/filter_expense.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/controller/summary_controller.dart';
import '../../widgets/paisa_chip.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../cubit/budget_cubit.dart';
import '../widgets/category_list_widget.dart';
import '../widgets/filter_date_range_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder(
                        bloc: budgetCubit,
                        buildWhen: (previous, current) =>
                            current is InitialSelectedState,
                        builder: (context, state) {
                          if (state is InitialSelectedState) {
                            return SizedBox(
                              height: 70,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
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
                      Expanded(
                        child: BlocBuilder(
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
  const BarChartSample2({super.key, required this.expense});

  final List<Expense> expense;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  late int maxLength = 0;
  late List<BarChartGroupData> showingBarGroups = [];
  int touchedGroupIndex = -1;
  final double width = 7;

  @override
  void initState() {
    super.initState();
    final map = groupBy(widget.expense, (Expense expense) => expense.type);
    final expenses = map[TransactionType.expense] ?? [];
    final income = map[TransactionType.income] ?? [];
    maxLength = max(expenses.length, income.length);
    for (var i = 0; i < maxLength; i++) {
      double y1 = 0, y2 = 0;
      try {
        y1 = income[i].currency;
        y2 = expenses[i].currency;
      } catch (_) {}

      showingBarGroups.add(makeGroupData(i, y1, y2));
    }
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 100000) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      value.toString(),
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.green,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.red,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: showingBarGroups.length * 40.0,
        child: BarChart(
          BarChartData(
            gridData: FlGridData(
              show: false,
            ),
            alignment: BarChartAlignment.spaceEvenly,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.red,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipMargin: 6,
                fitInsideVertically: true,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(rod.toY.toCurrency(),
                      Theme.of(context).textTheme.subtitle2!);
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta) {
                    print(value.toString());
                    return Text(
                      DateFormat("MMM\nyy").format(
                          DateTime.fromMillisecondsSinceEpoch(value.round())),
                      style: Theme.of(context).textTheme.subtitle2!,
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: AxisTitles(
                drawBehindEverything: true,
                sideTitles: SideTitles(
                  interval: 25000,
                  showTitles: true,
                  reservedSize: 50,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: showingBarGroups,
            maxY: [...showingBarGroups]
                .sorted((a, b) =>
                    a.barRods.first.toY.compareTo(b.barRods.first.toY))
                .last
                .barRods
                .first
                .toY,
          ),
        ),
      ),
    );
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: maxLength * 10,
          child: BarChart(
            BarChartData(
              maxY: 20,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.grey,
                  getTooltipItem: (a, b, c, d) => null,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 42,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 28,
                    interval: 1,
                    getTitlesWidget: leftTitles,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: showingBarGroups,
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }
}
