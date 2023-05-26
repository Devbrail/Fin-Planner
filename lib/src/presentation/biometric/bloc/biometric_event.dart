part of 'biometric_bloc.dart';

abstract class BiometricEvent extends Equatable {
  const BiometricEvent();

  @override
  List<Object> get props => [];
}

class CheckBiometricEvent extends BiometricEvent {}
