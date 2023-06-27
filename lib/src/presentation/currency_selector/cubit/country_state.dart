part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class NavigateToLading extends CountryState {
  const NavigateToLading(this.noNeedToSelect);

  final bool noNeedToSelect;

  @override
  List<Object> get props => [noNeedToSelect, identityHashCode(this)];
}

class CountriesState extends CountryState {
  const CountriesState(this.countries);

  final List<CountryModel> countries;

  @override
  List<Object> get props => [countries];
}
