import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../common/enum/box_types.dart';
import '../../../data/local_auth/local_auth_api.dart';
import '../../../data/settings/settings_service.dart';
import '../../../di/service_locator.dart';
import '../../../main.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<CheckLoginEvent>(_checkLogin);
  }
  late final settings = Hive.box(BoxType.settings.stringValue);
  final SettingsService service = locator.get();
  final LocalAuthApi localAuthApi = locator.get();

  FutureOr<void> _checkLogin(
    CheckLoginEvent event,
    Emitter<SplashState> emit,
  ) async {
    final languageCode = settings.get(userLanguageKey, defaultValue: 'DEF');
    //emit(CountryLocalesState(locales));

    if (languageCode == 'DEF') {
      emit(const CountryLocalesState(locales));
    } else {
      currentLocale = languageCode;
      final isEnable = await service.biometric();
      if (isEnable) {
        final isAuthenticate = await localAuthApi.authenticate();
        if (isAuthenticate) {
          emit(NavigateToHome());
        } else {
          emit(BiometricErrorState());
        }
      } else {
        emit(NavigateToHome());
      }
    }
  }

  Future<void> setSelectedLocale(Locale locale) async {
    await settings.put(userLanguageKey, locale.languageCode);
    add(CheckLoginEvent());
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
};
