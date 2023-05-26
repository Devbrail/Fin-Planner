import 'package:flutter_test/flutter_test.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/data/currencies/models/country_model.dart';

void main() {
  test('symbol on left', () {
    final CountryModel countryModel = CountryModel.fromJson({
      "code": "USD",
      "name": "United States Dollar",
      "symbol": "\$",
      "flag": "USD",
      "decimal_digits": 2,
      "number": 840,
      "name_plural": "US dollars",
      "thousands_separator": ",",
      "decimal_separator": ".",
      "space_between_amount_and_symbol": false,
      "symbol_on_left": true,
    });

    final String result = 123456.00.toFormateCurrency();
    expect(result, '\$1,23,456.00');
  });
  test('symbol on right', () {
    final CountryModel countryModel = CountryModel.fromJson(
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

    final String result = 123456.00.toFormateCurrency();
    expect(result, '1 23 456,00€');
  });
  test('no decimal digits', () {
    final CountryModel countryModel = CountryModel.fromJson(
      {
        "code": "CHF",
        "name": "Switzerland Franc",
        "symbol": "CHF",
        "flag": "CHF",
        "decimal_digits": 2,
        "number": 756,
        "name_plural": "Swiss francs",
        "thousands_separator": "'",
        "decimal_separator": ".",
        "space_between_amount_and_symbol": true,
        "symbol_on_left": true,
        "pattern": "\u00A0#,##0.00",
      },
    );

    final String result = 123456.00.toFormateCurrency();
    expect(result, 'CHF123\'456.00');
  });
}
