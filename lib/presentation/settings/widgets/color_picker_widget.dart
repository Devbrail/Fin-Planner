import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../common/enum/box_types.dart';
import '../../../data/settings/settings_service.dart';
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
  late final settings = Hive.box(BoxType.settings.stringValue)
      .listenable(keys: [appColorKey, dynamicColorKey]);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: settings,
      builder: (context, value, _) {
        final isDynamic = value.get(dynamicColorKey, defaultValue: false);
        final color = value.get(appColorKey, defaultValue: 0xFF795548);
        return SettingsOption(
          title: AppLocalizations.of(context)!.accentColor,
          subtitle: isDynamic
              ? AppLocalizations.of(context)!.dynamicColor
              : AppLocalizations.of(context)!.custom,
          trailing: CircleAvatar(
            backgroundColor: Color(color),
            maxRadius: 16,
          ),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              context: context,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width >= 700
                    ? 700
                    : double.infinity,
              ),
              builder: (context) =>
                  ColorSelectionWidget(valueListenable: settings),
            );
          },
        );
      },
    );
  }
}

class ColorSelectionWidget extends StatefulWidget {
  final ValueListenable<Box<dynamic>> valueListenable;
  const ColorSelectionWidget({
    Key? key,
    required this.valueListenable,
  }) : super(key: key);

  @override
  _ColorSelectionWidgetState createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  late bool isAndroid12 = false;

  @override
  void initState() {
    super.initState();
    _fetchInfo();
  }

  Future<void> _fetchInfo() async {
    final info = await DeviceInfoPlugin().androidInfo;
    final sdk = info.version.sdkInt ?? 0;
    isAndroid12 = sdk <= 29;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: widget.valueListenable,
        builder: (context, value, _) {
          final isDynamic = value.get(dynamicColorKey, defaultValue: false);
          final selectedColor =
              value.get(appColorKey, defaultValue: 0xFF795548);

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
                if (!isAndroid12) const DynamicColorSwitchWidget(),
                AbsorbPointer(
                  absorbing: isDynamic,
                  child: Opacity(
                    opacity: isDynamic ? 0.3 : 1,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      shrinkWrap: true,
                      itemCount: Colors.primaries.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width >= 700 ? 9 : 6,
                      ),
                      itemBuilder: (_, index) {
                        final color = Colors.primaries[index].shade500;
                        if (color == selectedColor) {
                          return Stack(
                            children: [
                              Center(
                                  child: CircleAvatar(backgroundColor: color)),
                              const Center(child: Icon(Icons.check)),
                            ],
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              value.put(appColorKey, color.value);
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      //widget.onSelectedColor(selectedColor);
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.done),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
