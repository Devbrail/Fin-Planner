import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../di/service_locator.dart';
import '../bloc/settings_controller.dart';
import 'dynamic_color_switch_widget.dart';
import 'setting_option.dart';

class ColorSelectorWidget extends StatefulWidget {
  final Function(Color) onSelectedColor;

  const ColorSelectorWidget({
    Key? key,
    required this.onSelectedColor,
  }) : super(key: key);

  @override
  _ColorSelectorWidgetState createState() => _ColorSelectorWidgetState();
}

class _ColorSelectorWidgetState extends State<ColorSelectorWidget> {
  final SettingsController dataSources = locator.get();
  late Color selectedColor = dataSources.currentColor;

  void _updateColor(Color color) {
    selectedColor = color;
    setState(() {});
    widget.onSelectedColor(color);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: AppLocalizations.of(context)!.accentColor,
      subtitle: AppLocalizations.of(context)!.custom,
      trailing: CircleAvatar(
        backgroundColor: selectedColor,
        maxRadius: 16,
      ),
      onTap: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          context: context,
          builder: (context) => ColorSelectionWidget(
            onSelectedColor: (color) {
              _updateColor(color);
            },
            dataSources: dataSources,
            selectedColor: selectedColor,
          ),
        );
      },
    );
  }
}

class ColorSelectionWidget extends StatefulWidget {
  final Function(Color) onSelectedColor;
  final Color selectedColor;
  final SettingsController dataSources;

  const ColorSelectionWidget({
    Key? key,
    required this.onSelectedColor,
    required this.selectedColor,
    required this.dataSources,
  }) : super(key: key);

  @override
  _ColorSelectionWidgetState createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  late Color selectedColor = widget.dataSources.currentColor;
  late bool isDynamic = widget.dataSources.dynamicColor;
  late bool isAndroid12 = false;
  @override
  void initState() {
    super.initState();
    _fetchInfo();
  }

  void _updateColor(Color color) {
    debugPrint(color.value.toString());
    selectedColor = color;
    setState(() {});
  }

  Future<void> _fetchInfo() async {
    final info = await DeviceInfoPlugin().androidInfo;
    final sdk = info.version.sdkInt ?? 0;
    isAndroid12 = sdk <= 29;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.pickColor,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          if (!isAndroid12)
            DynamicColorSwitchWidget(
              settingsController: widget.dataSources,
              onChange: (value) {
                isDynamic = value;
              },
            ),
          AbsorbPointer(
            absorbing: isDynamic,
            child: Opacity(
              opacity: isDynamic ? 0.3 : 1,
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                shrinkWrap: true,
                itemCount: Colors.primaries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                ),
                itemBuilder: (_, index) {
                  final color = Colors.primaries[index].shade500;
                  if (color == selectedColor) {
                    return Stack(
                      children: [
                        Center(child: CircleAvatar(backgroundColor: color)),
                        const Center(child: Icon(Icons.check)),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        _updateColor(color);
                      },
                      child: Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                widget.onSelectedColor(selectedColor);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.done),
            ),
          ),
        ],
      ),
    );
  }
}
