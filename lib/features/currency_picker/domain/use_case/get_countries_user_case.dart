import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/features/currency_picker/data/models/country_model.dart';
import 'package:paisa/features/currency_picker/domain/repository/country_repository.dart';

@injectable
class GetCountriesUseCase {
  GetCountriesUseCase({required this.repository});

  final CountryRepository repository;

  List<CountryModel> call() =>
      repository.fetchCountries().sorted((a, b) => a.name.compareTo(b.name));
}
