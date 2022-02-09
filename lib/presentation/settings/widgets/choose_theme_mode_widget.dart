import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/enum/theme_mode.dart';
import '../../../di/service_locator.dart';
import '../bloc/settings_controller.dart';
import 'setting_option.dart';

class ChooseThemeModeWidget extends StatefulWidget {
  const ChooseThemeModeWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ChooseThemeModeWidgetState createState() => _ChooseThemeModeWidgetState();
}

class _ChooseThemeModeWidgetState extends State<ChooseThemeModeWidget> {
  final SettingsController settingsController = locator.get();
  late ThemeMode selectedThemeMode = ThemeMode.system;
  @override
  void initState() {
    super.initState();
    selectedThemeMode = settingsController.themeMode;
  }

  void showThemeDialog() {
    showModalBottomSheet(
      constraints: BoxConstraints(
        maxWidth:
            MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      context: context,
      builder: (context) => ThemeModeWidget(
        onSelected: (selected) {
          selectedThemeMode = selected;
          settingsController.updateThemeMode(selectedThemeMode);
        },
        curentTheme: selectedThemeMode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: AppLocalizations.of(context)!.theme,
      subtitle: selectedThemeMode.themeName,
      onTap: () => showThemeDialog(),
    );
  }
}

class ThemeModeWidget extends StatefulWidget {
  const ThemeModeWidget({
    Key? key,
    required this.onSelected,
    required this.curentTheme,
  }) : super(key: key);
  final ThemeMode curentTheme;

  final Function(ThemeMode) onSelected;
  @override
  _ThemeModeWidgetState createState() => _ThemeModeWidgetState();
}

class _ThemeModeWidgetState extends State<ThemeModeWidget> {
  late ThemeMode curentIndex = widget.curentTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ...ThemeMode.values
              .map(
                (e) => RadioListTile(
                  value: e,
                  activeColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  groupValue: curentIndex,
                  onChanged: (ThemeMode? value) {
                    curentIndex = value!;
                    widget.onSelected(curentIndex);
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 16),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
          ),
        ],
      ),
    );
  }
}
