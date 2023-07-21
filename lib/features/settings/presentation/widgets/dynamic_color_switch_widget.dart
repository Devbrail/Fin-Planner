import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:paisa/core/common.dart';
import 'package:provider/provider.dart';
import 'setting_option.dart';

class DynamicColorSwitchWidget extends StatelessWidget {
  const DynamicColorSwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SettingsOption(
          title: context.loc.dynamicColor,
          trailing: Switch(
            activeColor: context.primary,
            value: Provider.of<Box<dynamic>>(context).get(
              dynamicThemeKey,
              defaultValue: false,
            ),
            onChanged: (value) {
              Provider.of<Box<dynamic>>(context).put(dynamicThemeKey, value);
              setState(() {});
            },
          ),
        );
      },
    );
  }
}
