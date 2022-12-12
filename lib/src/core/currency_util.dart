import 'package:flutter_paisa/src/core/common.dart';
import 'package:flutter_paisa/src/core/enum/box_types.dart';
import 'package:hive_flutter/adapters.dart';

import '../service_locator.dart';
import 'package:intl/intl.dart';

extension MappingOnDouble on double {
  String toCurrency({int decimalDigits = 2}) {
    return NumberFormat.simpleCurrency(
      locale: locator
          .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
          .get(userLanguageKey),
      decimalDigits: decimalDigits,
    ).format(this);
  }
}
