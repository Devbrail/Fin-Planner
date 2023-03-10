import 'package:paisa/src/data/currencies/models/currency.dart';

abstract class CurrenciesRepository {
  List<Currency> fetchCurrencies();
}
