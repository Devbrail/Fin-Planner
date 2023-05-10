import 'package:intl/intl.dart';

import '../app/routes.dart';
import '../data/currencies/models/country_model.dart';
import 'common.dart';

final model = CountryModel.fromJson(
  {
    "code": "EUR",
    "name": "Euro",
    "symbol": "€",
    "flag": "EUR",
    "decimal_digits": 2,
    "number": 978,
    "name_plural": "Euros",
    "thousands_separator": " ",
    "decimal_separator": ",",
    "space_between_amount_and_symbol": true,
    "symbol_on_left": false,
  },
);

extension MappingOnDouble on double {
  String toCurrency({int decimalDigits = 2}) {
    //return NumberFormat('#,##0.00', 'en_US').format(this);
    //return asThousands(separator: model.thousandsSeparator).leftOrRight;
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

extension MappingString on String {
  String get leftOrRight {
    if (model.symbolOnLeft) {
      return '${model.symbol}$this';
    } else {
      return '$this${model.symbol}';
    }
  }
}

String formatNumber(double number) {
  NumberFormat format = NumberFormat("#,##0.00", "en_US");
  String formattedNumber = format
      .format(number)
      .replaceAll(",", "temp")
      .replaceAll(".", ",")
      .replaceAll("temp", ".");
  return formattedNumber;
}

String formatNumberv1(double number) {
  String formattedNumber =
      number.toStringAsFixed(2); // format the number with 2 decimal places
  List<String> parts =
      formattedNumber.split('.'); // split the number by the decimal separator
  parts[0] = parts[0].replaceAllMapped(RegExp(r'(\d{3})(?=\d)'),
      (match) => '${match[1]}.'); // add dots as thousands separators
  return parts
      .join(','); // join the parts with a comma as the decimal separator
}

//void main() {
  //double number = 1234567.89;
  //String formattedNumber = formatNumber(number);
  //print(formattedNumber); // Output: 1.234.567,89
//}
