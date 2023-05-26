import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/settings/authenticate.dart';

part 'biometric_state.dart';

@injectable
class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit(this.authenticate) : super(BiometricInitial()) {}
  final Authenticate authenticate;

  void checkBiometric() {
    authenticate.canCheckBiometrics().then((canCheckBiometrics) {
      if (canCheckBiometrics) {
        authenticate.authenticateWithBiometrics().then((result) {
          if (result) {
            emit(const NavigateToHome(true));
          } else {
            //SystemNavigator.pop();
          }
        });
      }
    });
  }
}
