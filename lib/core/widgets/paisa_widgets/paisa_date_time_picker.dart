import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';

Future<TimeOfDay?> paisaTimerPicker(
  BuildContext context,
) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerThemeData(
            helpTextStyle: context.titleLarge,
            dayPeriodTextStyle: context.titleMedium,
            hourMinuteTextStyle: context.headlineMedium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            hourMinuteShape: const CircleBorder(),
          ),
        ),
        child: child!,
      );
    },
  );
}

Future<DateTime?> paisaDatePicker(
  BuildContext context, {
  required DateTime selectedDateTime,
}) {
  return showDatePicker(
    context: context,
    initialDate: selectedDateTime,
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            headerHelpStyle: context.titleMedium,
            headerHeadlineStyle: context.headlineMedium,
          ),
        ),
        child: child!,
      );
    },
  );
}
