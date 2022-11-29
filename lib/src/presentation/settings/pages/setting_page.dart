import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/app_builder.dart';
import '../../../app/routes.dart';
import '../../../core/constants.dart';
import '../../../core/context_extensions.dart';
import '../../../di/service_locator.dart';
import '../bloc/settings_controller.dart';
import '../widgets/choose_theme_mode_widget.dart';
import '../widgets/color_picker_widget.dart';
import '../widgets/currency_change_widget.dart';
import '../widgets/schedule_notification_widget.dart';
import '../widgets/setting_option.dart';
import '../widgets/settings_group_card.dart';
import '../widgets/user_profile_widget.dart';
import '../widgets/version_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsController settingsController = locator.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(
        AppLocalizations.of(context)!.settingsLabel,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SettingsOption(
            title: AppLocalizations.of(context)!.profileLabel,
            onTap: () {
              showModalBottomSheet(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width >= 700
                      ? 700
                      : double.infinity,
                ),
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                context: context,
                builder: (_) => const UserProfilePage(),
              );
            },
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          SettingsGroup(
            title: AppLocalizations.of(context)!.colorsLabel,
            options: [
              const ChooseThemeModeWidget(),
              const Divider(),
              ColorSelectorWidget(
                onSelectedColor: (color) => AppBuilder.of(context)?.rebuild(),
              ),
            ],
          ),
          SettingsGroup(
            title: AppLocalizations.of(context)!.othersLabel,
            options: [
              const CurrencyChangeWidget(),
              const Divider(),
              const ScheduleNotificationWidget(),
              const Divider(),
              SettingsOption(
                title: AppLocalizations.of(context)!.backupAndRestoreLabel,
                subtitle:
                    AppLocalizations.of(context)!.backupAndRestoreDescLabel,
                onTap: () => GoRouter.of(context).pushNamed(exportAndImport),
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
