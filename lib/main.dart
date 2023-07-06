import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import 'src/app.dart';
import 'src/core/common.dart';
import 'src/core/enum/box_types.dart';
import 'src/di/di.dart';
import 'src/domain/recurring/repository/recurring_repository.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjector(getIt);
  getIt.get<RecurringRepository>().checkForRecurring();
  final listenale =
      getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name).listenable(
    keys: [appColorKey, dynamicThemeKey, themeModeKey, userCountryKey],
  );
  runApp(PaisaApp(settingsListenable: listenale));
}
