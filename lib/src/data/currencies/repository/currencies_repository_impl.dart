import 'package:injectable/injectable.dart';
import '../data_source/country_data.dart';

import '../../../domain/currencies/repository/currencies_repository.dart';
import '../models/country_model.dart';

@Singleton(as: CurrenciesRepository)
class CurrencySelectorRepositoryImpl implements CurrenciesRepository {
  @override
  List<CountryModel> fetchCountries() {
    return List<CountryModel>.from(
        countriesdata.map((x) => CountryModel.fromJson(x)));
  }
}
