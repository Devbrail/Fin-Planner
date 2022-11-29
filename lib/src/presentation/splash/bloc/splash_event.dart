part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class CheckLoginEvent extends SplashEvent {
  final bool forceChangeCurrency;

  const CheckLoginEvent({this.forceChangeCurrency = false});
}

class FilterLocaleEvent extends SplashEvent {
  final String query;

  const FilterLocaleEvent(this.query);
}
