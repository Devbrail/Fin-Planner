import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../main.dart';
import '../../core/common.dart';
import '../../core/enum/box_types.dart';
import '../../core/enum/theme_mode.dart';

class ChooseThemeModeWidget extends StatefulWidget {
  const ChooseThemeModeWidget({
    Key? key,
    required this.currentTheme,
  }) : super(key: key);
  final ThemeMode currentTheme;

  @override
  ChooseThemeModeWidgetState createState() => ChooseThemeModeWidgetState();
}

class ChooseThemeModeWidgetState extends State<ChooseThemeModeWidget> {
  late ThemeMode currentIndex = widget.currentTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              context.loc.chooseThemeLabel,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...ThemeMode.values
              .map(
                (e) => RadioListTile(
                  value: e,
                  activeColor: Theme.of(context).colorScheme.primary,
                  groupValue: currentIndex,
                  onChanged: (ThemeMode? value) {
                    currentIndex = value!;
                    setState(() {});
                  },
                  title: Text(
                    e.themeName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              )
              .toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.loc.cancelLabel),
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
                  onPressed: () => getIt
                      .get<Box<dynamic>>(instanceName: BoxType.settings.name)
                      .put(themeModeKey, currentIndex.index)
                      .then((value) => Navigator.pop(context)),
                  child: Text(context.loc.okLabel),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
