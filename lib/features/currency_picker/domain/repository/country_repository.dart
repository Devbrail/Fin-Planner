import 'package:paisa/features/currency_picker/data/models/country_model.dart';

abstract class CountryRepository {
  List<CountryModel> fetchCountries();
}
