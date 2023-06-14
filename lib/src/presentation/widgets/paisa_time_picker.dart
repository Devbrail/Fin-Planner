import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            helpTextStyle: GoogleFonts.outfit(
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
            dayPeriodTextStyle: GoogleFonts.outfit(
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
            hourMinuteTextStyle: GoogleFonts.outfit(
              textStyle: Theme.of(context).textTheme.headlineMedium,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            hourMinuteShape: const CircleBorder(),
          ),
        ),
        child: child!,
      );
    },
  );
}
