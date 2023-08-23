// yyyy/mm/dd
// yy/mm/dd
// mm/dd/yyyy
// mm/dd/yy
// dd/mm/yyyy
// dd/mm/yyyy
import 'package:intl/intl.dart';

enum CalendarFormats {
  yyyymmdd,
  yymmdd,
  mmddyyyy,
  mmddyy,
  ddmmyyyy,
  ddmmyy;

  String get format {
    return switch (this) {
      CalendarFormats.yyyymmdd => 'yyyy/MM/dd',
      CalendarFormats.yymmdd => 'yy/MM/dd',
      CalendarFormats.mmddyyyy => 'MM/dd/yyyy',
      CalendarFormats.mmddyy => 'MM/dd/yy',
      CalendarFormats.ddmmyyyy => 'dd/MM/yyyy',
      CalendarFormats.ddmmyy => 'dd/MM/yy',
    };
  }

  DateFormat get dateFormat => DateFormat(format);

  String get exampleValue {
    return dateFormat.format(DateTime.now());
  }
}
