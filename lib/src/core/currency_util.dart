import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import 'common.dart';
import 'enum/box_types.dart';

extension MappingOnDouble on double {
  String toCurrency({int decimalDigits = 2}) {
    return NumberFormat.simpleCurrency(
      locale: getIt
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .get(userLanguageKey),
      decimalDigits: decimalDigits,
    ).format(this);
  }
}
