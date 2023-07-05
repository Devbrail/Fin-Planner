import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

import '../../../data/currencies/models/country_model.dart';
import '../repository/currencies_repository.dart';

@injectable
class GetCountriesUseCase {
  GetCountriesUseCase({required this.repository});

  final CurrenciesRepository repository;

  List<CountryModel> call() =>
      repository.fetchCountries().sorted((a, b) => a.name.compareTo(b.name));
}
