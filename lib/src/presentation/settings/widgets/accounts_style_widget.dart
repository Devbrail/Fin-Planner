import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../controller/settings_controller.dart';

class AccountsStyleWidget extends StatefulWidget {
  const AccountsStyleWidget({super.key});

  @override
  State<AccountsStyleWidget> createState() => _AccountsStyleWidgetState();
}

class _AccountsStyleWidgetState extends State<AccountsStyleWidget> {
  late bool isSelected =
      settings.get(userAccountsStyleKey, defaultValue: false);

  final SettingsController settings = getIt.get<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('Accounts style'),
      subtitle: Text(
          'Select your preferred account display style: vertical or horizontal'),
      onChanged: (bool value) async {
        setState(() {
          isSelected = value;
        });
        settings.put(userAccountsStyleKey, value);
      },
      value: isSelected,
    );
  }
}
