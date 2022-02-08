import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/local_auth/local_auth_api.dart';
import '../../../di/service_locator.dart';
import '../bloc/settings_controller.dart';
import 'setting_option.dart';

class BiotmetricWidget extends StatefulWidget {
  const BiotmetricWidget({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;
  @override
  _BiotmetricWidgetState createState() => _BiotmetricWidgetState();
}

class _BiotmetricWidgetState extends State<BiotmetricWidget> {
  late bool showNotificatons = false;
  final LocalAuthApi localAuthApi = locator.get();

  @override
  void initState() {
    super.initState();
    showNotificatons = widget.settingsController.showNotificatons;
  }

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: AppLocalizations.of(context)!.biometric,
      trailing: Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        value: showNotificatons,
        onChanged: (value) {
          showNotificatons = value;
          setState(() {});
          if (value) {
            checkAndUpdateLocalAuth(value);
          } else {
            widget.settingsController.updateBiometric(false);
          }
        },
      ),
    );
  }

  Future<void> checkAndUpdateLocalAuth(bool value) async {
    final isAuthenticate = await localAuthApi.authenticate();
    if (isAuthenticate) {
      widget.settingsController.updateBiometric(isAuthenticate);
    }
  }
}
