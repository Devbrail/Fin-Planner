import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../bloc/settings_controller.dart';

class SmallSizeFabWidget extends StatefulWidget {
  const SmallSizeFabWidget({super.key});

  @override
  State<SmallSizeFabWidget> createState() => _SmallSizeFabWidgetState();
}

class _SmallSizeFabWidgetState extends State<SmallSizeFabWidget> {
  final SettingsController settings = getIt.get<SettingsController>();
  late bool isSelected = settings.get(smallSizeFabKey, defaultValue: false);
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        context.loc.smallSizeFab,
      ),
      subtitle: Text(context.loc.smallSizeFabMessage),
      onChanged: (bool value) async {
        setState(() {
          isSelected = value;
        });
        settings.put(smallSizeFabKey, value);
      },
      value: isSelected,
    );
  }
}
