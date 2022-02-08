import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/app_builder.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../bloc/settings_controller.dart';
import '../widgets/biometric_auth_widget.dart';
import '../widgets/choose_theme_mode_widget.dart';
import '../widgets/color_picker_widget.dart';
import '../widgets/export_expenses_widget.dart';
import '../widgets/schedule_notification_widget.dart';
import '../widgets/setting_option.dart';
import '../widgets/settings_group_card.dart';
import '../widgets/user_profile_widget.dart';
import '../widgets/version_widget.dart';

class SettingMobilePage extends StatefulWidget {
  const SettingMobilePage({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  State<SettingMobilePage> createState() => _SettingMobilePageState();
}

class _SettingMobilePageState extends State<SettingMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: materialYouAppBar(
        context,
        AppLocalizations.of(context)!.settings,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SettingsOption(
            title: AppLocalizations.of(context)!.profile,
            onTap: () {
              showModalBottomSheet(
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
            title: AppLocalizations.of(context)!.colors,
            options: [
              const ChooseThemeModeWidget(),
              const Divider(),
              ColorSelectorWidget(
                onSelectedColor: (color) {
                  widget.settingsController.updateColor(color);
                  AppBuilder.of(context)?.rebuild();
                },
              ),
            ],
          ),
          SettingsGroup(
            title: AppLocalizations.of(context)!.others,
            options: [
              const ScheduleNotificationWidget(),
              const Divider(),
              BiotmetricWidget(
                settingsController: widget.settingsController,
              ),
              const Divider(),
              const ExportExpensesWidget(),
            ],
          ),
          SettingsGroup(
            title: AppLocalizations.of(context)!.socialLinks,
            options: [
              SettingsOption(
                title: AppLocalizations.of(context)!.github,
                subtitle: AppLocalizations.of(context)!.githubText,
                onTap: () => launch('https://github.com/h4h13/paisa'),
              ),
              const Divider(),
              SettingsOption(
                title: AppLocalizations.of(context)!.telegram,
                subtitle: AppLocalizations.of(context)!.telegramGroup,
                onTap: () => launch('https://t.me/app_paisa'),
              ),
              const Divider(),
              SettingsOption(
                title: AppLocalizations.of(context)!.privacyPolicy,
                onTap: () => launch('https://hemanths.dev/privacy'),
              ),
              const Divider(),
              const VersionWidget(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(AppLocalizations.of(context)!.madeWithLoveInIndia),
          ),
        ],
      ),
    );
  }
}
