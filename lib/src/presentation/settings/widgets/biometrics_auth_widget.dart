import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../widgets/future_resolve.dart';
import '../../../../main.dart';

import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../data/settings/authenticate.dart';

class BiometricAuthWidget extends StatefulWidget {
  const BiometricAuthWidget({
    super.key,
    required this.authenticate,
  });

  final Authenticate authenticate;

  @override
  State<BiometricAuthWidget> createState() => _BiometricAuthWidgetState();
}

class _BiometricAuthWidgetState extends State<BiometricAuthWidget> {
  final settings = getIt.get<Box<dynamic>>(
    instanceName: BoxType.settings.name,
  );
  late bool isSelected = settings.get(userAuthKey, defaultValue: false);

  @override
  Widget build(BuildContext context) => FutureResolve<List<bool>>(
        future: Future.wait([
          widget.authenticate.isDeviceSupported(),
          widget.authenticate.canCheckBiometrics()
        ]),
        builder: (supported) {
          return Visibility(
            visible: supported.every((element) => element),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(context.loc.localAppLabel),
                  onChanged: (bool value) async {
                    bool isAuthenticated = false;
                    if (value) {
                      isAuthenticated = await widget.authenticate
                          .authenticateWithBiometrics();
                    }
                    setState(() {
                      isSelected = value && isAuthenticated;
                    });
                    _showSnackBar(isSelected);
                  },
                  value: isSelected,
                ),
                const Divider(),
              ],
            ),
          );
        },
      );

  void _showSnackBar(bool result) => settings
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
