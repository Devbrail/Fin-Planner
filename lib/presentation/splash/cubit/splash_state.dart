part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class BiometricErrorState extends SplashState {}

class CountryLocalesState extends SplashState {
  final Map<String, Locale> locales;

  CountryLocalesState(this.locales);
}

class NavigateToHome extends SplashState {}
