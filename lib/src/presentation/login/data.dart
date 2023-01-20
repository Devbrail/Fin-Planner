import 'package:flutter/material.dart';

List<CountryMap> getLocales() => [
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
      CountryMap("Russian Ruble", const Locale('ru')),
      CountryMap("Chinese Yuan", const Locale('zh')),
      CountryMap("Australia Dollar", const Locale('en_AU')),
      CountryMap("Canadian Dollar", const Locale('en_CA')),
      CountryMap("British Pound", const Locale('en_GB')),
      CountryMap("Swedish Krona", const Locale('sv')),
    ];

class CountryMap {
  final String name;
  final Locale locale;

  CountryMap(this.name, this.locale);
}
