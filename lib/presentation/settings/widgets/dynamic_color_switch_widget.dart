import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/settings_controller.dart';
import 'setting_option.dart';

class DynamicColorSwitchWidget extends StatefulWidget {
  final Function(bool) onChange;
  final SettingsController settingsController;

  const DynamicColorSwitchWidget({
    Key? key,
    required this.onChange,
    required this.settingsController,
  }) : super(key: key);

  @override
  _DynamicColorSwitchWidgetState createState() =>
      _DynamicColorSwitchWidgetState();
}

class _DynamicColorSwitchWidgetState extends State<DynamicColorSwitchWidget> {
  late bool isDynamic = widget.settingsController.dynamicColor;

  @override
  void initState() {
    super.initState();
    widget.onChange(isDynamic);
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
          widget.settingsController.setDynamicColor(value);
          widget.onChange(value);
        },
      ),
    );
  }
}
