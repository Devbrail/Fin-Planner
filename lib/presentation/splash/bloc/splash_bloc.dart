import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paisa/data/accounts/model/account.dart';
import 'package:flutter_paisa/data/category/model/category.dart';
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
  final service = locator.get<SettingsService>();
  final localAuthApi = locator.get<LocalAuthApi>();
  late final settings = Hive.box(BoxType.settings.stringValue);
  late final accounts = Hive.box<Account>(BoxType.accounts.stringValue);
  late final categorys = Hive.box<Category>(BoxType.category.stringValue);

  FutureOr<void> _checkLogin(
    CheckLoginEvent event,
    Emitter<SplashState> emit,
  ) async {
    final name = await settings.get(userNameKey, defaultValue: '');
    if (name == '') {
      emit(NavigateToUserName());
      return;
    }

    final image = await settings.get(userImageKey, defaultValue: '');
    if (image == '') {
      emit(NavigateToUserImage());
      return;
    }

    final isAnyAccount = accounts.values.isEmpty;
    if (isAnyAccount) {
      emit(NavigateToAccount());
      return;
    }

    final isAnyCategory = categorys.values.isEmpty;
    if (isAnyCategory) {
      emit(NavigateToCategory());
      return;
    }

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
