import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';

class SmallSizeFabWidget extends StatefulWidget {
  const SmallSizeFabWidget({super.key});

  @override
  State<SmallSizeFabWidget> createState() => _SmallSizeFabWidgetState();
}

class _SmallSizeFabWidgetState extends State<SmallSizeFabWidget> {
  late bool isSelected = settings.get(smallSizeFabKey, defaultValue: false);
  final settings = getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);

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
