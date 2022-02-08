import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

const errorString = AndroidAuthMessages(
  signInTitle: "Authenticate for Login",
  cancelButton: 'Cancel',
  goToSettingsButton: 'Settings',
  goToSettingsDescription: 'Please register your Fingerprint',
);

class LocalAuthApi {
  final _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      return _auth.canCheckBiometrics;
    } on PlatformException catch (_) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    final isAvaliable = await hasBiometrics();
    if (!isAvaliable) return false;
    try {
      return _auth.authenticate(
        localizedReason: 'Scan',
        useErrorDialogs: true,
        stickyAuth: true,
        androidAuthStrings: errorString,
        biometricOnly: true,
      );
    } on PlatformException catch (_) {
      return false;
    }
  }
}
