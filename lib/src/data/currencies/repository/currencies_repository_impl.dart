import 'package:injectable/injectable.dart';

import '../../../domain/currencies/repository/currencies_repository.dart';
import '../models/country.dart';
import '../models/currency.dart';

@Singleton(as: CurrenciesRepository)
class CurrencySelectorRepositoryImpl implements CurrenciesRepository {
  @override
  List<Currency> fetchCurrencies() {
    return getLocales();
  }

  @override
  List<Country> fetchCountries() {
    return countryFromJson();
  }
}
