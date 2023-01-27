import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/currency_util.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);
  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withOpacity(0.85),
              ),
        ),
        const SizedBox(height: 8),
        Text(
          amount.toCurrency(),
          style: GoogleFonts.manrope(
            textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}
