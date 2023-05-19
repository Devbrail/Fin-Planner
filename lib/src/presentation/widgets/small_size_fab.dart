import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../main.dart';
import '../../core/common.dart';
import '../../core/enum/box_types.dart';

class SmallSizeFab extends StatelessWidget {
  const SmallSizeFab({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final settings = getIt.get<Box<dynamic>>(
      instanceName: BoxType.settings.name,
    );
    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: settings.listenable(keys: [smallSizeFabKey]),
      builder: (context, value, child) {
        final isSmallSize = value.get(smallSizeFabKey, defaultValue: false);
        return ScreenTypeLayout(
          breakpoints: const ScreenBreakpoints(
            tablet: 673,
            desktop: 799,
            watch: 300,
          ),
          mobile: Visibility(
            maintainState: true,
            visible: isSmallSize,
            replacement: FloatingActionButton.large(
              onPressed: onPressed,
              child: Icon(icon),
            ),
            child: FloatingActionButton(
              onPressed: onPressed,
              child: Icon(icon),
            ),
          ),
          tablet: FloatingActionButton(
            onPressed: onPressed,
            child: Icon(icon),
          ),
        );
      },
    );
  }
}
