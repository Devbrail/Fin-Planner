import 'package:injectable/injectable.dart';

import '../../../domain/currencies/repository/currencies_repository.dart';
import '../models/country_model.dart';
import '../models/currency_model.dart';

@Singleton(as: CurrenciesRepository)
class CurrencySelectorRepositoryImpl implements CurrenciesRepository {
  @override
  List<CurrencyModel> fetchCurrencies() {
    return getLocales();
  }

  @override
  List<CountryModel> fetchCountries() {
    return countryFromJson();
  }
}
