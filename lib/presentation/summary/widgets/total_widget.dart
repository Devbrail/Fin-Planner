import 'package:flutter/material.dart';
import 'package:flutter_paisa/common/constants/currency.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({
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
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        Text(
          formattedCurrency(amount),
          style: GoogleFonts.manrope(
            textStyle: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
