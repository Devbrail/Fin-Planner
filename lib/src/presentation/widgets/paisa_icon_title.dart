import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/extensions/build_context_extension.dart';

class PaisaIconTitle extends StatelessWidget {
  const PaisaIconTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.wallet,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          context.loc.appTitle,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            textStyle: Theme.of(context).textTheme.titleLarge,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
