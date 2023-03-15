import 'package:paisa/src/data/currencies/models/country.dart';

import '../../../data/currencies/models/currency.dart';

abstract class CurrenciesRepository {
  List<Currency> fetchCurrencies();
  List<Country> fetchCountries();
}
