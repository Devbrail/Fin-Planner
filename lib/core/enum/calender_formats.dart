// yyyy/mm/dd
// yy/mm/dd
// mm/dd/yyyy
// mm/dd/yy
// dd/mm/yyyy
// dd/mm/yyyy
import 'package:intl/intl.dart';

enum CalenderFormats {
  yyyymmdd,
  yymmdd,
  mmddyyyy,
  mmddyy,
  ddmmyyyy,
  ddmmyy;

  String get format {
    return switch (this) {
      CalenderFormats.yyyymmdd => 'yyyy/MM/dd',
      CalenderFormats.yymmdd => 'yy/MM/dd',
      CalenderFormats.mmddyyyy => 'MM/dd/yyyy',
      CalenderFormats.mmddyy => 'MM/dd/yy',
      CalenderFormats.ddmmyyyy => 'dd/MM/yyyy',
      CalenderFormats.ddmmyy => 'dd/MM/yy',
    };
  }

  DateFormat get dateFormat => DateFormat(format);

  String get exampleValue {
    return dateFormat.format(DateTime.now());
  }
}
