import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants.dart';
import '../../../core/context_extensions.dart';
import '../../../core/enum/box_types.dart';
import '../../../service_locator.dart';
import '../widgets/choose_theme_mode_widget.dart';
import '../widgets/color_picker_widget.dart';
import '../widgets/currency_change_widget.dart';
import '../widgets/setting_option.dart';
import '../widgets/settings_group_card.dart';
import '../widgets/version_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(
        AppLocalizations.of(context)!.settingsLabel,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SettingsGroup(
            title: AppLocalizations.of(context)!.colorsLabel,
            options: [
              ChooseThemeModeWidget(
                settings: locator.get(
                  instanceName: BoxType.settings.stringValue,
                ),
              ),
              ColorSelectorWidget(
                settings: locator.get(
                  instanceName: BoxType.settings.stringValue,
                ),
              ),
            ],
          ),
          SettingsGroup(
            title: AppLocalizations.of(context)!.othersLabel,
            options: [
              const CurrencyChangeWidget(),
              Divider(color: Theme.of(context).dividerColor),
              SettingsOption(
                title: AppLocalizations.of(context)!.backupAndRestoreLabel,
                subtitle:
                    AppLocalizations.of(context)!.backupAndRestoreDescLabel,
                onTap: () {
                  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Disabled',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      elevation: 6,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  //GoRouter.of(context).pushNamed(exportAndImport);
                },
              ),
            ],
          ),
          SettingsGroup(
            title: AppLocalizations.of(context)!.socialLinksLabel,
            options: [
              SettingsOption(
                title: AppLocalizations.of(context)!.appRateLabel,
                subtitle: AppLocalizations.of(context)!.appRateDescLabel,
                onTap: () => launchUrl(
                  Uri.parse(playStoreUrl),
                  mode: LaunchMode.externalApplication,
                ),
              ),
              const Divider(),
              SettingsOption(
                title: AppLocalizations.of(context)!.githubLabel,
                subtitle: AppLocalizations.of(context)!.githubTextLabel,
                onTap: () => launchUrl(
                  Uri.parse(gitHubUrl),
                  mode: LaunchMode.externalApplication,
                ),
              ),
              const Divider(),
              SettingsOption(
                title: AppLocalizations.of(context)!.telegramLabel,
                subtitle: AppLocalizations.of(context)!.telegramGroupLabel,
                onTap: () => launchUrl(
                  Uri.parse(telegramGroupUrl),
                  mode: LaunchMode.externalApplication,
                ),
              ),
              const Divider(),
              SettingsOption(
                title: AppLocalizations.of(context)!.privacyPolicyLabel,
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
            child: Text(AppLocalizations.of(context)!.madeWithLoveInIndiaLabel),
          ),
        ],
      ),
    );
  }
}
