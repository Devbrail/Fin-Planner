import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../data/settings/authenticate.dart';
import '../../../service_locator.dart';

class BiometricAuthWidget extends StatefulWidget {
  const BiometricAuthWidget({super.key, required this.authenticate});
  final Authenticate authenticate;
  @override
  State<BiometricAuthWidget> createState() => _BiometricAuthWidgetState();
}

class _BiometricAuthWidgetState extends State<BiometricAuthWidget> {
  final settings = locator.get<Box<dynamic>>(
    instanceName: BoxType.settings.stringValue,
  );
  late bool isSelected = settings.get(userAuthKey, defaultValue: false);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(context.loc.localAppLabel),
      onChanged: (bool value) async {
        final canAuth = await widget.authenticate.checkBiometrics();
        if (canAuth && value) {
          await widget.authenticate.authenticateWithBiometrics();
        }
        setState(() {
          isSelected = canAuth && value;
        });
        _showSnackBar(isSelected);
      },
      value: isSelected,
    );
  }

  void _showSnackBar(bool result) {
    settings
        .put(userAuthKey, result)
        .then((value) => ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(
                content: Text(
                  result ? 'Authenticated' : 'Not authenticated',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ));
  }
}
