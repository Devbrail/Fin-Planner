import 'package:paisa/src/data/currencies/models/country_model.dart';

import '../../../data/currencies/models/currency_model.dart';

abstract class CurrenciesRepository {
  List<CurrencyModel> fetchCurrencies();
  List<CountryModel> fetchCountries();
}
