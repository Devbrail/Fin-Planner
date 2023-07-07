import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../../../data/currencies/models/country_model.dart';
import '../../../domain/currencies/use_case/get_countries_user_case.dart';
import '../../settings/controller/settings_controller.dart';

part 'country_state.dart';

@injectable
class CountryCubit extends Cubit<CountryState> {
  CountryCubit(
    this.getCountryUseCase,
    this.settings,
  ) : super(CountryInitial());

  final GetCountriesUseCase getCountryUseCase;
  CountryModel? selectedCountry;
  final SettingsController settings;

  void checkForData() {
    final Map<dynamic, dynamic>? json = settings.get(userCountryKey);
    if (json == null) {
      fetchCountry();
    } else {
      selectedCountry = CountryModel.fromJson(json);
      settings
          .put(userCountryKey, selectedCountry!.toJson())
          .then((value) => emit(const NavigateToLading(false)));
    }
  }

  void fetchCountry() {
    List<CountryModel> countries = getCountryUseCase();
    emit(CountriesState(countries));
  }

  void filterCountry(String value) {
    List<CountryModel> countries = getCountryUseCase()
        .where(
          (element) =>
              element.name.toLowerCase().contains(value.toLowerCase()) ||
              element.code.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();
    emit(CountriesState(countries));
  }

  void saveCountry() {
    if (selectedCountry == null) return;

    settings.put(userCountryKey, selectedCountry!.toJson());
    settings.put(userLanguageKey, selectedCountry!.code);
    emit(const NavigateToLading(true));
  }
}
