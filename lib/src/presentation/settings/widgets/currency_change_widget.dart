import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

class CurrencyChangeWidget extends StatelessWidget {
  const CurrencyChangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          context.go('/splash', extra: {'force_change_currency': true}),
      title: Text(AppLocalizations.of(context)!.currencySignLabel),
      subtitle: Text(NumberFormat.compactSimpleCurrency(locale: currentLocale)
              .currencyName ??
          ''),
    );
  }
}
