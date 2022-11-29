import '../di/service_locator.dart';
import 'package:intl/intl.dart';

extension MappingOnDouble on double {
  String toCurrency({int decimalDigits = 2}) {
    return NumberFormat.simpleCurrency(
      locale: locator.get<String>(instanceName: 'languageCode'),
      decimalDigits: decimalDigits,
    ).format(this);
  }
}
