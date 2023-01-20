import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../service_locator.dart';
import 'common.dart';
import 'enum/box_types.dart';

extension MappingOnDouble on double {
  String toCurrency({int decimalDigits = 2}) => NumberFormat.simpleCurrency(
        locale: locator
            .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
            .get(userLanguageKey),
        decimalDigits: decimalDigits,
      ).format(this);
}
