import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import '../../../core/common.dart';
import '../../widgets/future_resolve.dart';
import 'dynamic_color_switch_widget.dart';
import 'setting_option.dart';

class ColorSelectorWidget extends StatelessWidget {
  const ColorSelectorWidget({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final Box<dynamic> settings;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: settings.listenable(keys: [
        appColorKey,
        dynamicThemeKey,
      ]),
      builder: (context, value, _) {
        final isDynamic = value.get(dynamicThemeKey, defaultValue: false);
        final color = value.get(appColorKey, defaultValue: 0xFF795548);
        return SettingsOption(
          title: context.loc.accentColorLabel,
          subtitle: isDynamic
              ? context.loc.dynamicColorLabel
              : context.loc.customLabel,
          trailing: CircleAvatar(
            backgroundColor: Color(color),
            maxRadius: 16,
          ),
          onTap: () => showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            context: context,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width >= 700
                  ? 700
                  : double.infinity,
            ),
            builder: (context) => ColorSelectionWidget(
              valueListenable: settings.listenable(),
            ),
          ),
        );
      },
    );
  }
}

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({
    Key? key,
    required this.valueListenable,
  }) : super(key: key);

  final ValueListenable<Box<dynamic>> valueListenable;

  @override
  Widget build(BuildContext context) {
    return FutureResolve<AndroidDeviceInfo>(
      future: DeviceInfoPlugin().androidInfo,
      builder: (info) {
        final sdk = info.version.sdkInt ?? 0;
        bool isAndroid12 = sdk >= 29;
        return ValueListenableBuilder<Box<dynamic>>(
          valueListenable: valueListenable,
          builder: (context, value, _) {
            final bool isDynamic = value.get(
              dynamicThemeKey,
              defaultValue: false,
            );
            int selectedColor = value.get(
              appColorKey,
              defaultValue: 0xFF795548,
            );

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListTile(
                    title: Text(
                      context.loc.pickColorLabel,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Visibility(
                    visible: isAndroid12,
                    child: DynamicColorSwitchWidget(settings: value),
                  ),
                  AbsorbPointer(
                    absorbing: isDynamic,
                    child: Opacity(
                      opacity: isDynamic ? 0.3 : 1,
                      child: ColorPickerGridWidget(
                        onSelected: (color) {
                          selectedColor = color;
                        },
                        selectedColor: selectedColor,
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
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () => value
                          .put(appColorKey, selectedColor)
                          .then((value) => Navigator.pop(context)),
                      child: Text(context.loc.doneLabel),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ColorPickerGridWidget extends StatefulWidget {
  const ColorPickerGridWidget({
    super.key,
    required this.onSelected,
    required this.selectedColor,
  });
  final Function(int) onSelected;
  final int selectedColor;

  @override
  State<ColorPickerGridWidget> createState() => _ColorPickerGridWidgetState();
}

class _ColorPickerGridWidgetState extends State<ColorPickerGridWidget> {
  late int selectedColor = widget.selectedColor;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 16),
      shrinkWrap: true,
      itemCount: Colors.primaries.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width >= 700 ? 9 : 6,
      ),
      itemBuilder: (_, index) {
        final color = Colors.primaries[index].value;
        if (color == selectedColor) {
          return Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 42,
                  width: 42,
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 2, color: Color(color)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(color),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      margin: const EdgeInsets.all(4),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              widget.onSelected.call(color);
              setState(() {
                selectedColor = color;
              });
            },
            child: Center(
              child: CircleAvatar(
                backgroundColor: Color(color),
              ),
            ),
          );
        }
      },
    );
  }
}
