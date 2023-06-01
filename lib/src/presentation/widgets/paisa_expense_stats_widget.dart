import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'paisa_card.dart';

class PaisaExpenseStatsWidget extends StatelessWidget {
  final String total;
  final String title;
  final Color graphLineColor;
  final IconData iconData;

  const PaisaExpenseStatsWidget({
    super.key,
    required this.total,
    required this.title,
    required this.graphLineColor,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: PaisaFilledCard(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 16,
                backgroundColor: graphLineColor.withOpacity(0.3),
                child: Icon(
                  iconData,
                  color: graphLineColor,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withOpacity(0.75),
                                ),
                      ),
                      Text(
                        total,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      tablet: PaisaFilledCard(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.75),
                ),
          ),
          subtitle: Text(
            total,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
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
