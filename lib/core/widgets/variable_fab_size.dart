import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:paisa/core/common.dart';
import 'package:provider/provider.dart';

class VariableFABSize extends StatelessWidget {
  const VariableFABSize({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: Provider.of<Box<dynamic>>(context).listenable(
        keys: [
          smallSizeFabKey,
        ],
      ),
      builder: (context, value, child) {
        final isSmallSize = value.get(smallSizeFabKey, defaultValue: false);
        if (isSmallSize) {
          return FloatingActionButton(
            onPressed: onPressed,
            child: Icon(icon),
          );
        } else {
          return FloatingActionButton.large(
            onPressed: onPressed,
            child: Icon(icon),
          );
        }
      },
    );
  }
}
