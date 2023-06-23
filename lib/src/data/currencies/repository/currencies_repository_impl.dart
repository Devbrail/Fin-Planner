import 'package:injectable/injectable.dart';

import '../../../domain/currencies/repository/currencies_repository.dart';
import '../models/country_model.dart';

@Singleton(as: CurrenciesRepository)
class CurrencySelectorRepositoryImpl implements CurrenciesRepository {
  @override
  List<CountryModel> fetchCountries() {
    return countryFromJson();
  }
}
