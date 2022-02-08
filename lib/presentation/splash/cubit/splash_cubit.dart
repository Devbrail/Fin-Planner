import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/splash_screen/datasource/splash_local_data_sources.dart';

import '../../../data/local_auth/local_auth_api.dart';
import '../../../data/settings/settings_service.dart';
import '../../../di/service_locator.dart';
import '../../../main.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.splashUseCase,
  }) : super(SplashInitial());

  final SplashLocalDataSource splashUseCase;
  final SettingsService service = locator.get();
  final LocalAuthApi localAuthApi = locator.get();

  void checkLogin() {
    splashUseCase.getLanguage().then((value) {
      //emit(CountryLocalesState(locales));
      if (value.languageCode == 'INR') {
        emit(CountryLocalesState(locales));
      } else {
        currentLocale = value;
        _checkBiometric();
      }
    });
  }

  void _checkBiometric() {
    service.biometric().then((value) {
      if (value) {
        _checkAuthentication();
      } else {
        _navigateToRespectivePage();
      }
    });
  }

  void _checkAuthentication() {
    localAuthApi.authenticate().then((value) {
      if (value) {
        _navigateToRespectivePage();
      } else {
        emit(BiometricErrorState());
      }
    });
  }

  void _navigateToRespectivePage() =>
      Future.delayed(const Duration(milliseconds: 400))
          .then((value) => emit(NavigateToHome()));

  void setSeledetdLocale(Locale locale) {
    splashUseCase.setLanguage(locale).then((value) => checkLogin());
  }
}

const Map<String, Locale> locales = {
  "US Doller": Locale('en'),
  "Indian Rupee": Locale('hi'),
  "Malaysia Ringgit": Locale('ms'),
  "Ukrainian Hryvnia": Locale('uk'),
  "Polish Złoty": Locale('pl'),
  "Austria Euro": Locale('de'),
  "Bangladesh Taka": Locale('bn'),
  "Indonesian Rupiah": Locale('id'),
};
