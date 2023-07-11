import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../domain/settings/use_case/setting_use_case.dart';

class AccountsStyleWidget extends StatefulWidget {
  const AccountsStyleWidget({super.key});

  @override
  State<AccountsStyleWidget> createState() => _AccountsStyleWidgetState();
}

class _AccountsStyleWidgetState extends State<AccountsStyleWidget> {
  final SettingsUseCase settingsUseCase = getIt.get();
  late bool isSelected =
      settingsUseCase.get(userAccountsStyleKey, defaultValue: false);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(MdiIcons.creditCard),
      title: Text(context.loc.accountStyle),
      subtitle: Text(context.loc.accountStyleDescription),
      onChanged: (bool value) async {
        setState(() {
          isSelected = value;
        });
        settingsUseCase.put(userAccountsStyleKey, value);
      },
      value: isSelected,
    );
  }
}
