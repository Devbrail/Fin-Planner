import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/main.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/core/enum/box_types.dart';

class SmallSizeFabWidget extends StatefulWidget {
  const SmallSizeFabWidget({super.key});

  @override
  State<SmallSizeFabWidget> createState() => _SmallSizeFabWidgetState();
}

class _SmallSizeFabWidgetState extends State<SmallSizeFabWidget> {
  final settings = getIt.get<Box<dynamic>>(
    instanceName: BoxType.settings.name,
  );
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
