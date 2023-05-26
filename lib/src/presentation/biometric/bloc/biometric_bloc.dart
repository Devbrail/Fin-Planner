import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../main.dart';
import '../../../data/settings/authenticate.dart';

part 'biometric_event.dart';
part 'biometric_state.dart';

@injectable
class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  BiometricBloc(this.authenticate) : super(BiometricInitial()) {
    on<BiometricEvent>((event, emit) {});
    on<CheckBiometricEvent>(_checkBiometric);
  }
  final Authenticate authenticate;

  FutureOr<void> _checkBiometric(
    CheckBiometricEvent event,
    Emitter<BiometricState> emit,
  ) async {
    final LocalAuthentication localAuth = LocalAuthentication();

    final bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    if (canCheckBiometrics) {
      final bool result = await localAuth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(),
      );
      if (result) {
        await Future.delayed(Duration.zero)
            .whenComplete(() => emit(const NavigateToHome(true)));
      } else {
        //SystemNavigator.pop();
      }
    } else {}
  }
}
