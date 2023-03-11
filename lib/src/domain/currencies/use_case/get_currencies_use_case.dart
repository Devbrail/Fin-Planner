import 'package:injectable/injectable.dart';

import '../../../data/currencies/models/currency.dart';
import '../repository/currencies_repository.dart';

@injectable
class GetCurrenciesUseCase {
  GetCurrenciesUseCase({required this.repository});

  final CurrenciesRepository repository;

  List<Currency> call() => repository.fetchCurrencies();
}
