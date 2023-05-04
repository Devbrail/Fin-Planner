import 'package:paisa/src/core/enum/recurring_type.dart';

extension RecurringTypeHelper on RecurringType {
  Duration get getTime {
    switch (this) {
      case RecurringType.daily:
        return const Duration(days: 1);
      case RecurringType.weekly:
        return const Duration(days: 7);
      case RecurringType.monthly:
        return const Duration(days: 30);
      case RecurringType.yearly:
        return const Duration(days: 365);
    }
  }
}
