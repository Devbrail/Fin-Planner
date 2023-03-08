import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../../../main.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';

class CurrencyChangeWidget extends StatelessWidget {
  const CurrencyChangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed(
        splashName,
        extra: {
          'force_change_currency': true,
        },
      ),
      title: Text(context.loc.currencySignLabel),
      subtitle: Text(
        NumberFormat.compactSimpleCurrency(
              locale: getIt
                  .get<Box<dynamic>>(instanceName: BoxType.settings.name)
                  .get(userLanguageKey),
            ).currencyName ??
            '',
      ),
    );
  }
}
