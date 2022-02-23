part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class BiometricErrorState extends SplashState {}

class CountryLocalesState extends SplashState {
  final Map<String, Locale> locales;

  const CountryLocalesState(this.locales);
}

class NavigateToHome extends SplashState {}
