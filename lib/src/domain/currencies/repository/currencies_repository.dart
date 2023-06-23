import '../../../data/currencies/models/country_model.dart';

abstract class CurrenciesRepository {
  List<CountryModel> fetchCountries();
}
