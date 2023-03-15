import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../core/enum/theme_mode.dart';
import '../../../data/settings/authenticate.dart';
import '../../widgets/choose_theme_mode_widget.dart';
import '../widgets/biometrics_auth_widget.dart';
import '../widgets/currency_change_widget.dart';
import '../widgets/setting_option.dart';
import '../widgets/settings_color_picker_widget.dart';
import '../widgets/settings_group_card.dart';
import '../widgets/version_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = getIt.get<Box<dynamic>>(
      instanceName: BoxType.settings.name,
    );
    final currentTheme = ThemeMode.values[getIt
        .get<Box<dynamic>>(instanceName: BoxType.settings.name)
        .get(themeModeKey, defaultValue: 0)];
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(context.loc.settingsLabel),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SettingsGroup(
                  title: context.loc.colorsLabel,
                  options: [
                    SettingsColorPickerWidget(settings: settings),
                    SettingsOption(
                      title: context.loc.chooseThemeLabel,
                      subtitle: currentTheme.themeName,
                      onTap: () {
                        showModalBottomSheet(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width >= 700
                                ? 700
                                : double.infinity,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          context: context,
                          builder: (_) => ChooseThemeModeWidget(
                            currentTheme: currentTheme,
                          ),
                        );
                      },
                    )
                  ],
                ),
                SettingsGroup(
                  title: context.loc.othersLabel,
                  options: [
                    const CurrencyChangeWidget(),
                    const Divider(),
                    BiometricAuthWidget(
                      authenticate: getIt.get<Authenticate>(),
                    ),
                    SettingsOption(
                      title: context.loc.backupAndRestoreLabel,
                      subtitle: context.loc.backupAndRestoreDescLabel,
                      onTap: () {
                        GoRouter.of(context).pushNamed(exportAndImport);
                      },
                    ),
                  ],
                ),
                SettingsGroup(
                  title: context.loc.socialLinksLabel,
                  options: [
                    SettingsOption(
                      title: context.loc.appRateLabel,
                      subtitle: context.loc.appRateDescLabel,
                      onTap: () => launchUrl(
                        Uri.parse(playStoreUrl),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    const Divider(),
                    SettingsOption(
                      title: context.loc.githubLabel,
                      subtitle: context.loc.githubTextLabel,
                      onTap: () => launchUrl(
                        Uri.parse(gitHubUrl),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    const Divider(),
                    SettingsOption(
                      title: context.loc.telegramLabel,
                      subtitle: context.loc.telegramGroupLabel,
                      onTap: () => launchUrl(
                        Uri.parse(telegramGroupUrl),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    const Divider(),
                    SettingsOption(
                      title: context.loc.privacyPolicyLabel,
                      onTap: () => launchUrl(
                        Uri.parse(termsAndConditionsUrl),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    const Divider(),
                    const VersionWidget(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(context.loc.madeWithLoveInIndiaLabel),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
