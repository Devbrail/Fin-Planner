import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/domain/expense/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<Expense> data;

  HorizontalBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 200,
        width: data.length * 50,
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) => Text('data'),
                ),
              ),
            ),
            barTouchData: BarTouchData(enabled: false),
            borderData: FlBorderData(show: false),
            barGroups: data
                .asMap()
                .map((index, value) => MapEntry(
                      index,
                      BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            color: Colors.blue,
                            width: 16,
                            toY: value.currency,
                          ),
                        ],
                      ),
                    ))
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    super.key,
    required this.expenses,
  });
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Stack();
  }
}
