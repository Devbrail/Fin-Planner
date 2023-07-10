import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../domain/settings/use_case/setting_use_case.dart';

class CurrencyChangeWidget extends StatelessWidget {
  const CurrencyChangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsUseCase settingsUseCase = getIt.get();
    final String currentSymbol =
        settingsUseCase.get(userLanguageKey, defaultValue: '');
    return ListTile(
      onTap: () {
        context.pushNamed(
          countrySelectorName,
          queryParameters: {
            'force_currency_selector': 'true',
          },
        );
      },
      title: Text(context.loc.currencySign),
      subtitle: Text(currentSymbol),
    );
  }
}
