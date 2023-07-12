import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../main.dart';
import '../../core/common.dart';
import '../../core/enum/box_types.dart';

class VariableSizeFAB extends StatelessWidget {
  const VariableSizeFAB({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: getIt
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .listenable(keys: [smallSizeFabKey]),
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
