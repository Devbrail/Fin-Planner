import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/currencies/repository/currencies_repository.dart';
import '../models/currency.dart';

@Singleton(as: CurrenciesRepository)
class CurrencySelectorRepositoryImpl implements CurrenciesRepository {
  @override
  List<Currency> fetchCurrencies() {
    return _getLocales();
  }
}

List<Currency> _getLocales() => [
      Currency("US Dollar", const Locale('en')),
      Currency("Indian Rupee", const Locale('hi')),
      Currency("Malaysia Ringgit", const Locale('ms')),
      Currency("Ukrainian Hryvnia", const Locale('uk')),
      Currency("Polish Złoty", const Locale('pl')),
      Currency("Austria Euro", const Locale('de')),
      Currency("Bangladesh Taka", const Locale('bn')),
      Currency("Turkish lira", const Locale('tr')),
      Currency("Mexican Peso", const Locale('es-mx')),
      Currency("Philippine Peso", const Locale('fil')),
      Currency("Indonesian Rupiah", const Locale('id')),
      Currency("Vietnamese Dong", const Locale('vi')),
      Currency("Lebanese Pound", const Locale('ar-lb')),
      Currency("Taiwan Dollar", const Locale('zh-tw')),
      Currency("Sri Lanka Rupee", const Locale('si')),
      Currency("Pakistan Rupee", const Locale('ur')),
      Currency("Swiss Franc", const Locale('fr_CH')),
      Currency("Egyptian Pound", const Locale('ar_EG')),
      Currency("Brazilian Real", const Locale('pt')),
      Currency("Russian Ruble", const Locale('ru')),
      Currency("Chinese Yuan", const Locale('zh')),
      Currency("Australia Dollar", const Locale('en_AU')),
      Currency("Canadian Dollar", const Locale('en_CA')),
      Currency("British Pound", const Locale('en_GB')),
      Currency("Swedish Krona", const Locale('sv')),
      Currency("Iranian Rial", const Locale('fa')),
      Currency("South African Rand", const Locale('zu')),
      Currency("New Taiwan dollar", const Locale('zh_TW')),
      Currency("Ethiopian Birr", const Locale('am')),
      Currency("Singapore Dollar", const Locale('en_SG')),
      Currency("Hungarian Forint", const Locale('hu')),
    ];
