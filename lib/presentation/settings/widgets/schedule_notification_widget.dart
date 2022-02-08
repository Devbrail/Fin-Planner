import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../di/service_locator.dart';
import '../bloc/settings_controller.dart';
import 'setting_option.dart';

class ScheduleNotificationWidget extends StatefulWidget {
  const ScheduleNotificationWidget({Key? key}) : super(key: key);

  @override
  _ScheduleNotificationWidgetState createState() =>
      _ScheduleNotificationWidgetState();
}

class _ScheduleNotificationWidgetState
    extends State<ScheduleNotificationWidget> {
  final SettingsController settingsController = locator.get();
  late bool showNotificatons = false;

  @override
  void initState() {
    super.initState();
    showNotificatons = settingsController.showNotificatons;
  }

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: AppLocalizations.of(context)!.reminder,
      subtitle: AppLocalizations.of(context)!.reminderDescription,
      trailing: Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        value: showNotificatons,
        onChanged: (value) {
          showNotificatons = value;
          setState(() {});
          settingsController.updateNotification(value);
        },
      ),
    );
  }
}
