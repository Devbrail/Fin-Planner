import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/main.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/core/enum/box_types.dart';

class SmallSizeFAb extends StatefulWidget {
  const SmallSizeFAb({super.key});

  @override
  State<SmallSizeFAb> createState() => _SmallSizeFAbState();
}

class _SmallSizeFAbState extends State<SmallSizeFAb> {
  final settings = getIt.get<Box<dynamic>>(
    instanceName: BoxType.settings.name,
  );
  late bool isSelected = settings.get(smallSizeFab, defaultValue: false);
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
        settings.put(smallSizeFab, value);
      },
      value: isSelected,
    );
  }
}
