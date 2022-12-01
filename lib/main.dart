import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import 'src/app/routes.dart';
import 'src/core/enum/box_types.dart';
import 'src/core/theme/paisa_theme.dart';
import 'src/data/settings/settings_service.dart';
import 'src/presentation/widgets/app_builder.dart';
import 'src/service_locator.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final settings = locator
      .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
      .listenable(
    keys: [
      appColorKey,
      dynamicColorKey,
      themeModeKey,
    ],
  );
  @override
  void initState() {
    setOptimalDisplayMode();
    super.initState();
  }

  Future<void> setOptimalDisplayMode() async {
    final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    final DisplayMode active = await FlutterDisplayMode.active;

    final List<DisplayMode> sameResolution = supported
        .where((DisplayMode m) =>
            m.width == active.width && m.height == active.height)
        .toList()
      ..sort((DisplayMode a, DisplayMode b) =>
          b.refreshRate.compareTo(a.refreshRate));

    final DisplayMode mostOptimalMode =
        sameResolution.isNotEmpty ? sameResolution.first : active;

    /// This setting is per session.
    /// Please ensure this was placed with `initState` of your root widget.
    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: settings,
      builder: (context, value, child) {
        final isDynamic = value.get(dynamicColorKey, defaultValue: true);
        final themeModeValue = value.get(themeModeKey, defaultValue: 0);
        final color = value.get(appColorKey, defaultValue: 0xFF795548);
        final primaryColor = Color(color);
        return AppBuilder(
          builder: (context) {
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
                    navigationBarTheme:
                        navigationBarThemeData(lightColorScheme),
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
                  themeMode: ThemeMode.values[themeModeValue],
                  localizationsDelegates: const [
                    AppLocalizations.delegate, // Add this line
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''),
                  ],
                  onGenerateTitle: (BuildContext context) =>
                      AppLocalizations.of(context)!.appTitle,
                );
              },
            );
          },
        );
      },
    );
  }
}
