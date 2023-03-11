import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/common.dart';
import '../../widgets/future_resolve.dart';
import '../../widgets/paisa_color_picker.dart';
import 'dynamic_color_switch_widget.dart';
import 'setting_option.dart';

class SettingsColorPickerWidget extends StatelessWidget {
  const SettingsColorPickerWidget({
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
            builder: (context) => ColorPickerDialogWidget(
              valueListenable: settings.listenable(),
            ),
          ),
        );
      },
    );
  }
}

class ColorPickerDialogWidget extends StatelessWidget {
  const ColorPickerDialogWidget({
    Key? key,
    required this.valueListenable,
  }) : super(key: key);

  final ValueListenable<Box<dynamic>> valueListenable;

  @override
  Widget build(BuildContext context) {
    return FutureResolve<AndroidDeviceInfo>(
      future: DeviceInfoPlugin().androidInfo,
      builder: (info) {
        final sdk = info.version.sdkInt;
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Visibility(
                    visible: isAndroid12,
                    child: DynamicColorSwitchWidget(settings: value),
                  ),
                  const Divider(),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: isDynamic
                        ? const SizedBox.shrink()
                        : ColorPickerGridWidget(
                            onSelected: (color) {
                              selectedColor = color;
                            },
                            selectedColor: selectedColor,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                    child: TextButton(
                      style: TextButton.styleFrom(
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
