import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/routes.dart';
import 'core/common.dart';
import 'core/enum/box_types.dart';
import 'core/theme/paisa_theme.dart';
import 'service_locator.dart';

class PaisaApp extends StatefulWidget {
  const PaisaApp({Key? key}) : super(key: key);

  @override
  State<PaisaApp> createState() => _PaisaAppState();
}

class _PaisaAppState extends State<PaisaApp> {
  late final settings = locator
      .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
      .listenable(
    keys: [
      appColorKey,
      dynamicThemeKey,
      themeModeKey,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: settings,
      builder: (context, value, _) {
        final bool isDynamic = value.get(dynamicThemeKey, defaultValue: true);
        final ThemeMode themeMode =
            ThemeMode.values[value.get(themeModeKey, defaultValue: 0)];
        final int color = value.get(appColorKey, defaultValue: 0xFF795548);
        final Color primaryColor = Color(color);
        return DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;
            if (lightDynamic != null && darkDynamic != null && isDynamic) {
              lightColorScheme = lightDynamic.harmonized();
              darkColorScheme = darkDynamic.harmonized();
            } else {
              lightColorScheme = ColorScheme.fromSeed(
                seedColor: primaryColor,
              );
              darkColorScheme = ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.dark,
              );
            }

            return MaterialApp.router(
              routeInformationProvider: goRouter.routeInformationProvider,
              routeInformationParser: goRouter.routeInformationParser,
              routerDelegate: goRouter.routerDelegate,
              debugShowCheckedModeBanner: false,
              theme: ThemeData.from(
                colorScheme: lightColorScheme,
              ).copyWith(
                colorScheme: lightColorScheme,
                dialogTheme: dialogTheme(),
                appBarTheme: appBarThemeLight(lightColorScheme),
                useMaterial3: true,
                textTheme: GoogleFonts.outfitTextTheme(
                  ThemeData.light().textTheme,
                ),
                scaffoldBackgroundColor: lightColorScheme.background,
                dialogBackgroundColor: lightColorScheme.background,
                navigationBarTheme: navigationBarThemeData(lightColorScheme),
                applyElevationOverlayColor: true,
                inputDecorationTheme: inputDecorationTheme,
                elevatedButtonTheme: elevatedButtonTheme(
                  context,
                  lightColorScheme,
                ),
                extensions: [lightCustomColor],
              ),
              darkTheme: ThemeData.from(
                colorScheme: darkColorScheme,
              ).copyWith(
                colorScheme: darkColorScheme,
                dialogTheme: dialogTheme(),
                appBarTheme: appBarThemeDark(darkColorScheme),
                useMaterial3: true,
                textTheme: GoogleFonts.outfitTextTheme(
                  ThemeData.dark().textTheme,
                ),
                scaffoldBackgroundColor: darkColorScheme.background,
                dialogBackgroundColor: darkColorScheme.background,
                navigationBarTheme: navigationBarThemeData(darkColorScheme),
                applyElevationOverlayColor: true,
                inputDecorationTheme: inputDecorationTheme,
                elevatedButtonTheme: elevatedButtonTheme(
                  context,
                  darkColorScheme,
                ),
                extensions: [darkCustomColor],
              ),
              themeMode: themeMode,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,
            );
          },
        );
      },
    );
  }
}
