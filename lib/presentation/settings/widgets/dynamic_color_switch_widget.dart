import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../../../data/settings/settings_service.dart';
import 'setting_option.dart';

class DynamicColorSwitchWidget extends StatefulWidget {
  const DynamicColorSwitchWidget({Key? key}) : super(key: key);

  @override
  _DynamicColorSwitchWidgetState createState() =>
      _DynamicColorSwitchWidgetState();
}

class _DynamicColorSwitchWidgetState extends State<DynamicColorSwitchWidget> {
  late final settings = Hive.box(BoxType.settings.stringValue);
  late bool isDynamic = settings.get(
    dynamicColorKey,
    defaultValue: false,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: AppLocalizations.of(context)!.dynamicColor,
      trailing: Switch(
        value: isDynamic,
        onChanged: (value) {
          setState(() {
            isDynamic = value;
          });
          settings.put(dynamicColorKey, value);
        },
      ),
    );
  }
}
