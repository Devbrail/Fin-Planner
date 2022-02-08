import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalTextWidget extends StatelessWidget {
  const TotalTextWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            textStyle: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ],
    );
  }
}
