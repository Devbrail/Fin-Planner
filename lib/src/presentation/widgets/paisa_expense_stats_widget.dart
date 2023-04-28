import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'paisa_card.dart';

class PaisaExpenseStatsWidget extends StatelessWidget {
  final String total;
  final String title;
  final List<double> graphData;
  final Color graphLineColor;

  const PaisaExpenseStatsWidget({
    super.key,
    required this.total,
    required this.title,
    required this.graphData,
    required this.graphLineColor,
  });

  @override
  Widget build(BuildContext context) {
    return PaisaFilledCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.75),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              total,
              style: GoogleFonts.manrope(
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Sparkline(
                  data: graphData,
                  useCubicSmoothing: true,
                  cubicSmoothingFactor: 0.2,
                  lineWidth: 3,
                  lineColor: graphLineColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
