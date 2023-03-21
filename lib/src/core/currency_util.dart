import 'package:intl/intl.dart';

import '../app/routes.dart';
import 'common.dart';

extension MappingOnDouble on double {
  String toCurrency({int decimalDigits = 2}) {
    final String? customCurrency = settings.get(userCustomCurrencyKey);
    if (customCurrency != null) {
      return settings.get(userCustomCurrencyKey, defaultValue: '\$') +
          NumberFormat("#,##0.00", "en_US").format(this);
    } else {
      return NumberFormat.simpleCurrency(
        locale: settings.get(userLanguageKey),
        decimalDigits: decimalDigits,
      ).format(this);
    }
  }
}
