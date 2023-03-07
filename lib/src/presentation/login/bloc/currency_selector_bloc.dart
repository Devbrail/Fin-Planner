import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/main.dart';
import 'package:paisa/src/core/enum/box_types.dart';

import '../../../core/common.dart';
import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/category/model/category.dart';
import '../data.dart';

part 'currency_selector_event.dart';
part 'currency_selector_state.dart';

@injectable
class CurrencySelectorBloc extends Bloc<SplashEvent, SplashState> {
  CurrencySelectorBloc({
    required this.accounts,
    required this.categories,
  }) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<CheckLoginEvent>(_checkLogin);
    on<FilterLocaleEvent>(_filterLocale);
    on<SelectedLocaleEvent>(_selectedLocale);
  }

  final Box<dynamic> settings =
      getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);
  final Box<Account> accounts;
  final Box<Category> categories;
  Locale? selectedLocale;

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
        amount: 0,
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

    if (languageCode == 'DEF' || event.forceChangeCurrency) {
      final locales = getLocales();
      locales.sort(((a, b) => a.name.compareTo(b.name)));
      emit(CountryLocalesState(locales));
    } else {
      await settings.put(userLanguageKey, languageCode);
      emit(NavigateToHome());
    }
  }

  void _filterLocale(
    FilterLocaleEvent event,
    Emitter<SplashState> emit,
  ) {
    final query = event.query.toLowerCase();
    final result = getLocales()
        .where((element) => element.name.toLowerCase().contains(query))
        .toList();
    result.sort(((a, b) => a.name.compareTo(b.name)));
    emit(CountryLocalesState(result));
  }

  FutureOr<void> _selectedLocale(
    SelectedLocaleEvent event,
    Emitter<SplashState> emit,
  ) async {
    if (selectedLocale == null) return;
    await settings.put(userLanguageKey, selectedLocale!.languageCode);
    emit(NavigateToHome());
  }
}
