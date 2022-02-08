import 'package:flutter/material.dart';

import '../../../di/service_locator.dart';
import '../bloc/settings_controller.dart';
import 'settings_mobile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsController settingsController = locator.get();
  @override
  Widget build(BuildContext context) {
    return SettingMobilePage(settingsController: settingsController);
  }
}
