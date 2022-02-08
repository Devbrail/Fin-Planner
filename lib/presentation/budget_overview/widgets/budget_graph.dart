import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TransactionGraph extends StatelessWidget {
  const TransactionGraph({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  final List<charts.Series<OrdinalSales, String>> seriesList;

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(30),
          maxBarWidthPx: 10),
    );
  }

  static List<charts.Series<OrdinalSales, String>> createSampleData(
      List<OrdinalSales> data) {
    return [
      charts.Series<OrdinalSales, String>(
        id: 'Budget',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class OrdinalSales {
  final String year;
  final num sales;

  OrdinalSales(this.year, this.sales);
}
