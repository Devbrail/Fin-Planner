import 'package:intl/intl.dart';

import '../main.dart';

extension MappingOnDouble on double {
  String toCurrency({int decimalDigits = 2}) {
    return NumberFormat.simpleCurrency(
      locale: currentLocale.toString(),
      decimalDigits: decimalDigits,
    ).format(this);
  }
}
