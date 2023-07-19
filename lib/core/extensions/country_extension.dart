import 'package:paisa/features/currency_picker/data/models/country_model.dart';
import 'package:paisa/features/currency_picker/domain/entities/country.dart';

extension CountryHelper on CountryModel {
  Country toEntity() {
    return Country(
      code: code,
      name: name,
      symbol: symbol,
      flag: flag,
      decimalDigits: decimalDigits,
      number: number,
      namePlural: namePlural,
      thousandsSeparator: thousandsSeparator,
      decimalSeparator: decimalSeparator,
      spaceBetweenAmountAndSymbol: spaceBetweenAmountAndSymbol,
      symbolOnLeft: symbolOnLeft,
      pattern: pattern,
    );
  }
}
