import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../../../data/currencies/models/country_model.dart';
import '../../../domain/currencies/use_case/get_country_user_case.dart';

part 'country_state.dart';

@injectable
class CountryCubit extends Cubit<CountryState> {
  CountryCubit(
    this.getCountryUseCase,
    @Named('settings') this.settings,
  ) : super(CountryInitial());

  final GetCountryUseCase getCountryUseCase;

  final Box<dynamic> settings;
  CountryModel? selectedCountry;

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
              element.name.toLowerCase().contains(value) ||
              element.code.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();
    emit(CountriesState(countries));
  }

  void saveCountry() {
    if (selectedCountry == null) return;

    settings.put(userCountryKey, selectedCountry!.toJson());
    emit(const NavigateToLading(true));
  }
}
