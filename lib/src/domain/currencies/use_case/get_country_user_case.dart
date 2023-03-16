import 'package:injectable/injectable.dart';

import '../../../data/currencies/models/country_model.dart';
import '../repository/currencies_repository.dart';

@injectable
class GetCurrenciesUseCase {
  GetCurrenciesUseCase({required this.repository});

  final CurrenciesRepository repository;

  List<CountryModel> call() => repository.fetchCountries();
}
