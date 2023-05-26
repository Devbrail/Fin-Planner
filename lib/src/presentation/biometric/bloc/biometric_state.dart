part of 'biometric_bloc.dart';

abstract class BiometricState extends Equatable {
  const BiometricState();

  @override
  List<Object> get props => [];
}

class BiometricInitial extends BiometricState {}

class NavigateToHome extends BiometricState {
  final bool noNeedToSelect;

  const NavigateToHome(this.noNeedToSelect);

  @override
  List<Object> get props => [noNeedToSelect, identityHashCode(this)];
}

class BiometricErrorState extends BiometricState {}
