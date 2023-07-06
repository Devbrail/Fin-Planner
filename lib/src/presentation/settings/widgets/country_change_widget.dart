import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../controller/settings_controller.dart';

class CountryChangeWidget extends StatelessWidget {
  const CountryChangeWidget({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final SettingsController settings;
  @override
  Widget build(BuildContext context) {
    final String currentSymbol =
        settings.get(userLanguageKey, defaultValue: 'INR') ?? '';
    return ListTile(
      onTap: () {
        context.pushNamed(
          countrySelectorName,
          queryParameters: {'force_country_selector': 'true'},
        );
      },
      title: Text(context.loc.currencySign),
      subtitle: Text(currentSymbol),
    );
  }
}
