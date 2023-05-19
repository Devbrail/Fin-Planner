import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'paisa_card.dart';

class PaisaExpenseStatsWidget extends StatelessWidget {
  final String total;
  final String title;
  final List<double> graphData;
  final Color graphLineColor;
  final IconData iconData;

  const PaisaExpenseStatsWidget({
    super.key,
    required this.total,
    required this.title,
    required this.graphData,
    required this.graphLineColor,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: PaisaFilledCard(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
          title: Text(
            title,
            style: GoogleFonts.outfit(
              textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withOpacity(0.75),
                  ),
            ),
          ),
          subtitle: Text(
            total,
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          leading: CircleAvatar(
            maxRadius: 16,
            backgroundColor: graphLineColor.withOpacity(0.3),
            child: Icon(
              iconData,
              color: graphLineColor,
            ),
          ),
        ),
      ),
      tablet: PaisaFilledCard(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
        child: ListTile(
          title: Text(
            title,
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withOpacity(0.75),
                  ),
            ),
          ),
          subtitle: Text(
            total,
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          leading: Align(
            widthFactor: 0.5,
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              maxRadius: 16,
              backgroundColor: graphLineColor.withOpacity(0.3),
              child: Icon(
                iconData,
                color: graphLineColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
