import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../common/enum/box_types.dart';
import '../../../common/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/category/model/category.dart';
import '../../../data/settings/settings_service.dart';
import '../../../di/service_locator.dart';
import '../../../main.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<CheckLoginEvent>(_checkLogin);
    on<FilterLocaleEvent>(_filterLocale);
  }
  final service = locator.get<SettingsService>();
  late final settings = Hive.box(BoxType.settings.stringValue);
  late final accounts = Hive.box<Account>(BoxType.accounts.stringValue);
  late final categories = Hive.box<Category>(BoxType.category.stringValue);

  FutureOr<void> _checkLogin(
    CheckLoginEvent event,
    Emitter<SplashState> emit,
  ) async {
    final isAnyAccount = accounts.values.isEmpty;
    if (isAnyAccount) {
      final account = Account(
        name: 'Holder name',
        icon: MdiIcons.creditCard.codePoint,
        bankName: 'Bank name',
        number: '1234',
        cardType: CardType.bank,
      );
      final int id = await accounts.add(account);
      account.superId = id;
      await account.save();
    }

    final isAnyCategory = categories.values.isEmpty;
    if (isAnyCategory) {
      final category = Category(
        name: 'Default',
        icon: MdiIcons.home.codePoint,
        description: 'All expenses',
        color:
            Colors.primaries[Random().nextInt(Colors.primaries.length)].value,
      );
      final int id = await categories.add(category);
      category.superId = id;
      category.save();
    }

    final languageCode = settings.get(userLanguageKey, defaultValue: 'DEF');
    //emit(CountryLocalesState(locales));

    if (languageCode == 'DEF' || event.forceChangeCurrency) {
      locales.sort(((a, b) => a.name.compareTo(b.name)));
      emit(CountryLocalesState(locales));
    } else {
      currentLocale = languageCode;
      emit(NavigateToHome());
    }
  }

  Future<void> setSelectedLocale(Locale locale) async {
    await settings.put(userLanguageKey, locale.languageCode);
    add(const CheckLoginEvent());
  }

  void _filterLocale(
    FilterLocaleEvent event,
    Emitter<SplashState> emit,
  ) {
    final query = event.query.toLowerCase();
    final result = locales
        .where((element) => element.name.toLowerCase().contains(query))
        .toList();
    result.sort(((a, b) => a.name.compareTo(b.name)));
    emit(CountryLocalesState(result));
  }
}

final locales = [
  CountryMap("US Dollar", const Locale('en')),
  CountryMap("Indian Rupee", const Locale('hi')),
  CountryMap("Malaysia Ringgit", const Locale('ms')),
  CountryMap("Ukrainian Hryvnia", const Locale('uk')),
  CountryMap("Polish Złoty", const Locale('pl')),
  CountryMap("Austria Euro", const Locale('de')),
  CountryMap("Bangladesh Taka", const Locale('bn')),
  CountryMap("Turkish lira", const Locale('tr')),
  CountryMap("Mexican Peso", const Locale('es-mx')),
  CountryMap("Philippine Peso", const Locale('fil')),
  CountryMap("Indonesian Rupiah", const Locale('id')),
  CountryMap("Vietnamese Dong", const Locale('vi')),
  CountryMap("Lebanese Pound", const Locale('ar-lb')),
  CountryMap("Taiwan Dollar", const Locale('zh-tw')),
  CountryMap("Sri Lanka Rupee", const Locale('si')),
  CountryMap("Pakistan Rupee", const Locale('ur')),
  CountryMap("Swiss Franc", const Locale('fr_CH')),
  CountryMap("Egyptian Pound", const Locale('ar_EG')),
  CountryMap("Brazilian Real", const Locale('pt')),
];

class CountryMap {
  final String name;
  final Locale locale;

  CountryMap(this.name, this.locale);
}
