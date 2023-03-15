import 'package:injectable/injectable.dart';

import '../../../data/currencies/models/country.dart';
import '../repository/currencies_repository.dart';

@injectable
class GetCurrenciesUseCase {
  GetCurrenciesUseCase({required this.repository});

  final CurrenciesRepository repository;

  List<Country> call() => repository.fetchCountries();
}
