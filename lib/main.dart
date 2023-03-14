import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:workmanager/workmanager.dart';

import 'src/app.dart';
import 'src/di/di.dart';
import 'src/di/module/data_module.dart';
import 'src/di/module/work.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await configInjector(getIt);
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(const PaisaApp());
}
