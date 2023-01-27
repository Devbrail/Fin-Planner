import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../service_locator.dart';
import '../widgets/currency_change_widget.dart';
import '../widgets/setting_option.dart';
import '../widgets/settings_color_picker_widget.dart';
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
        context.loc.settingsLabel,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SettingsGroup(
            title: context.loc.colorsLabel,
            options: [
              SettingsColorPickerWidget(
                settings: locator.get(
                  instanceName: BoxType.settings.stringValue,
                ),
              ),
            ],
          ),
          SettingsGroup(
            title: context.loc.othersLabel,
            options: [
              const CurrencyChangeWidget(),
              const Divider(),
              SettingsOption(
                title: context.loc.backupAndRestoreLabel,
                subtitle: context.loc.backupAndRestoreDescLabel,
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
    );
  }
}
