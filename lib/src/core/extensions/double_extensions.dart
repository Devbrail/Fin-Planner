import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../app/routes.dart';
import '../../domain/currencies/entities/country.dart';
import '../common.dart';

extension MappingOnDouble on double {
  String toFormateCurrencyOld({int decimalDigits = 2}) {
    return NumberFormat.simpleCurrency(
      locale: settings.get(userLanguageKey),
      decimalDigits: decimalDigits,
    ).format(this);
  }

  String toFormateCurrency(BuildContext context) {
    final Country country = Provider.of<Country>(context);
    final formatter = NumberFormat.currency(customPattern: country.pattern);
    if (country.symbolOnLeft) {
      return '${country.symbol}${country.spaceBetweenAmountAndSymbol ? ' ' : ''}${formatter.format(this)}'
          .replaceAll(',', country.thousandsSeparator)
          .replaceAll('.', country.decimalSeparator);
    } else {
      return '${formatter.format(this)}${country.spaceBetweenAmountAndSymbol ? ' ' : ''}${country.symbol}'
          .replaceAll(',', country.thousandsSeparator)
          .replaceAll('.', country.decimalSeparator);
    }
  }
}
