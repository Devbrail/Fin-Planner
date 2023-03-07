import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/di/di.dart';
import 'src/service_locator.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  //await setupLocator();
  await configInjector(getIt);
  await FlutterDisplayMode.setHighRefreshRate();
  getIt.allReady().then((value) => runApp(const PaisaApp()));
}
