import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_color.dart';

extension TextStyleMapping on TextStyle {
  TextStyle onPrimary(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onPrimary);
  }

  TextStyle onSecondary(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onSecondary);
  }

  TextStyle onTertiary(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onTertiary);
  }

  TextStyle onPrimaryContainer(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer);
  }

  TextStyle onSecondaryContainer(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer);
  }

  TextStyle onTertiaryContainer(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer);
  }

  TextStyle onSurface(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onSurface);
  }
}

extension ColorText on BuildContext {
  Color get onPrimary {
    return Theme.of(this).colorScheme.onPrimary;
  }

  Color get onPrimaryContainer {
    return Theme.of(this).colorScheme.onPrimaryContainer;
  }

  Color get onSecondary {
    return Theme.of(this).colorScheme.onSecondary;
  }

  Color get onSecondaryContainer {
    return Theme.of(this).colorScheme.onSecondaryContainer;
  }

  Color get onTertiary {
    return Theme.of(this).colorScheme.onTertiary;
  }

  Color get onTertiaryContainer {
    return Theme.of(this).colorScheme.onTertiaryContainer;
  }
}

ElevatedButtonThemeData elevatedButtonTheme(
  BuildContext context,
  ColorScheme colorScheme,
) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      textStyle: GoogleFonts.outfit(
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
    ),
  );
}

InputDecorationTheme get inputDecorationTheme {
  return InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    filled: true,
  );
}

NavigationBarThemeData navigationBarThemeData(ColorScheme colorScheme) {
  return NavigationBarThemeData(
    backgroundColor: colorScheme.surface,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    labelTextStyle: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return GoogleFonts.outfit().copyWith(fontWeight: FontWeight.bold);
      } else {
        return GoogleFonts.outfit();
      }
    }),
  );
}

FloatingActionButtonThemeData floatingActionButton(ColorScheme colorScheme) {
  return FloatingActionButtonThemeData(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
  );
}

AppBarTheme appBarThemeLight(ColorScheme colorScheme) {
  return AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
}

AppBarTheme appBarThemeDark(ColorScheme colorScheme) {
  return AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
}

DialogTheme get dialogTheme {
  return DialogTheme(
    titleTextStyle: GoogleFonts.manrope(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );
}

TimePickerThemeData get timePickerTheme {
  return TimePickerThemeData(
    helpTextStyle: GoogleFonts.manrope(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    hourMinuteShape: const CircleBorder(),
  );
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(alpha, (red * value).round(), (green * value).round(),
        (blue * value).round());
  }
}

CustomColors lightCustomColor = CustomColors(
  red: Colors.red.shade400,
  green: Colors.green.shade400,
  blue: Colors.blue.shade400,
);
CustomColors darkCustomColor = CustomColors(
  red: Colors.red.shade400,
  green: Colors.green.shade400,
  blue: Colors.blue.shade400,
);
