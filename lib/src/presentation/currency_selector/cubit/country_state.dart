part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class NavigateToLading extends CountryState {
  final bool noNeedToSelect;

  const NavigateToLading(this.noNeedToSelect);

  @override
  List<Object> get props => [noNeedToSelect, identityHashCode(this)];
}

class CountriesState extends CountryState {
  final List<CountryModel> countries;

  const CountriesState(this.countries);
  @override
  List<Object> get props => [countries];
}
