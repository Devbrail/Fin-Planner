import 'package:flutter/material.dart';

import '../../core/build_context_extension.dart';

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
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          context.loc.appTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
