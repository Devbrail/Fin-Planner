import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/di/di.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjector(getIt);
  //await addDummyData();
  runApp(const PaisaApp());
}
