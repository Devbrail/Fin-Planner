import 'package:intl/intl.dart';
import 'package:paisa/src/data/currencies/models/country_model.dart';

import '../../app/routes.dart';
import '../common.dart';

extension MappingOnDouble on double {
  String toFormateCurrencyOld({int decimalDigits = 2}) {
    final String? customCurrency = settings.get(userCustomCurrencyKey);
    if (customCurrency != null) {
      if (settings.get(userCustomCurrencyLeftOrRightKey, defaultValue: false)) {
        return settings.get(userCustomCurrencyKey, defaultValue: '\$') +
            NumberFormat("#,##0.00", "en_US").format(this);
      } else {
        return NumberFormat("#,##0.00", "en_US").format(this) +
            settings.get(userCustomCurrencyKey, defaultValue: '\$');
      }
    } else {
      return NumberFormat.simpleCurrency(
        locale: settings.get(userLanguageKey),
        decimalDigits: decimalDigits,
      ).format(this);
    }
  }

  String toFormateCurrency() {
    final json = settings.get(userCountryKey);
    final CountryModel countryModel = CountryModel.fromJson(json);
    final formatter =
        NumberFormat.currency(customPattern: countryModel.pattern);
    if (countryModel.symbolOnLeft) {
      return '${countryModel.symbol}${countryModel.spaceBetweenAmountAndSymbol ? ' ' : ''}${formatter.format(this)}'
          .replaceAll(',', countryModel.thousandsSeparator)
          .replaceAll('.', countryModel.decimalSeparator);
    } else {
      return '${formatter.format(this)}${countryModel.spaceBetweenAmountAndSymbol ? ' ' : ''}${countryModel.symbol}'
          .replaceAll(',', countryModel.thousandsSeparator)
          .replaceAll('.', countryModel.decimalSeparator);
    }
  }
}
