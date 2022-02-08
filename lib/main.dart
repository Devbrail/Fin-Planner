import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'app/app_builder.dart';
import 'app/routes.dart';
import 'common/constants/theme.dart';
import 'di/service_locator.dart';
import 'presentation/home/bloc/home_bloc.dart';
import 'presentation/settings/bloc/settings_controller.dart';

final GlobalKey<NavigatorState> mainNavigator = GlobalKey<NavigatorState>();
late Locale currentLocale;
Future<void> main() async {
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
  final HomeBloc expensBloc = locator.get();
  final SettingsController settingsController = locator.get();

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (context) {
        return DynamicColorBuilder(
          builder: (CorePalette? corePalette) {
            ColorScheme colorScheme = ColorScheme.fromSeed(
              seedColor: settingsController.currentColor,
            );
            ColorScheme darkColorScheme = ColorScheme.fromSeed(
              seedColor: settingsController.currentColor,
              brightness: Brightness.dark,
            );

            if (corePalette != null && settingsController.dynamicColor) {
              colorScheme = corePalette.colorScheme;
              darkColorScheme = corePalette.darkColorScheme;
              colorScheme = colorScheme.harmonized();
              darkColorScheme = darkColorScheme.harmonized();
            }
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => expensBloc),
              ],
              child: AnimatedBuilder(
                animation: settingsController,
                builder: (context, child) {
                  return MaterialApp(
                    navigatorKey: mainNavigator,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData.light().copyWith(
                      colorScheme: colorScheme,
                      dialogTheme: dialogTheme(),
                      appBarTheme: appBarTheme(Brightness.dark),
                      useMaterial3: true,
                      textTheme: GoogleFonts.outfitTextTheme(
                        ThemeData.light().textTheme,
                      ),
                      scaffoldBackgroundColor: colorScheme.background,
                      dialogBackgroundColor: colorScheme.background,
                      navigationBarTheme: navigationBarThemeData,
                      applyElevationOverlayColor: true,
                    ),
                    darkTheme: ThemeData.dark().copyWith(
                      colorScheme: darkColorScheme,
                      dialogTheme: dialogTheme(),
                      appBarTheme: appBarTheme(Brightness.light),
                      useMaterial3: true,
                      textTheme: GoogleFonts.outfitTextTheme(
                        ThemeData.dark().textTheme,
                      ),
                      scaffoldBackgroundColor: darkColorScheme.background,
                      dialogBackgroundColor: darkColorScheme.background,
                      navigationBarTheme: navigationBarThemeData,
                      applyElevationOverlayColor: true,
                    ),
                    themeMode: settingsController.themeMode,
                    onGenerateRoute: onGenerateRoute,
                    initialRoute: splashScreen,
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
              ),
            );
          },
        );
      },
    );
  }
}
